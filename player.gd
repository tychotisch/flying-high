extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $Animations
@onready var player: CharacterBody2D = $"."
@onready var timer_countdown: Timer = $CanvasLayer/Timer
@onready var countdownlabel: Label = $CanvasLayer/Countdownlabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var high_score_label: Label = $CanvasLayer/HighScoreLabel
@onready var menu: Control = $CanvasLayer/Menu
@onready var start_button: Button = $CanvasLayer/Menu/StartButton

const SPEED = 600.0
const JUMP_VELOCITY = -550.0
const DOWN_VELOCITY = 500

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_in_air := false
var direction := Input.get_axis("left", "right")
var push_force := 5
var player_alive := true
var score := 0
var high_score := 0

func _ready() -> void:
	Events.connect("player_hit", set_death)
	Events.connect("coin_picked", add_score)
	
	high_score_label.visible = false

func _physics_process(delta: float) -> void:
	
	if player_alive:
		playable_area()
		movement()
		apply_air_state()
		setting_animation()
		flipping_animation()
	
	if !player_alive and is_on_floor():
		menu.visible = true
		start_button.visible = false
		high_score_label.visible = true
	
	move_and_slide()
	apply_gravity(delta)
	pushing_rigids()

func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("escape"):
		show_menu()
	if menu.visible:
		get_tree().paused = true
	time_remaining()

func apply_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
func apply_air_state():
	if !is_on_floor():
		is_in_air = true
	else: 
		is_in_air = false
		
func setting_animation():
	if !is_on_floor():
		animation.play("moving")
	if is_on_floor():
		animation.play("idle")

func flipping_animation():
	if direction == 1:
		animation.flip_h = true
	if direction == -1:
		animation.flip_h = false 

func movement():
	if is_on_floor() or is_in_air:
		if Input.is_action_pressed("up"):
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("down"):
			velocity.y = DOWN_VELOCITY

	if !is_on_floor():
		direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

func pushing_rigids():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func playable_area():
	if position.x <= -1500:
		position.x = -1500
		Events.emit_signal("end_of_area")
		
func set_death():
	if player_alive:
		player.rotate(90)
		animation.stop()
		velocity.x = 0
		player_alive = false
		
	
func time_remaining():
	countdownlabel.set_text(str(timer_countdown.time_left).pad_decimals(2))
	
func add_score(value):
	score += value
	score_label.set_text(str(score))
	if score > high_score:
		high_score = score
		high_score_label.set_text("High score: " + str(high_score))
		

func show_menu():
	menu.visible = true

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	menu.visible = false

func _on_restart_button_pressed() -> void:
	Events.emit_signal("restart_game")


func _on_timer_timeout() -> void:
	player_alive = false
	menu.visible = true
	high_score_label.visible = true
