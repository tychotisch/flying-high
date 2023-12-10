extends Area2D

var speed := 60
var normal_speed := 60
var direction := 1
var idling = false
var shoot_cooldown := 75
var last_shot = 0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var idle_timer: Timer = $IdleTimer
@onready var walk_timer: Timer = $WalkTimer
@onready var foot_left: RayCast2D = $FootLeft
@onready var foot_right: RayCast2D = $FootRight
@onready var Laser := preload("res://objects/laser.tscn")
@onready var spawn_left: Marker2D = $Spawn_left
@onready var spawn_right: Marker2D = $Spawn_right
@onready var vision_left: RayCast2D = $VisionLeft
@onready var vision_right: RayCast2D = $VisionRight



func _ready() -> void:
	walk_timer.start(5)

func _physics_process(delta: float) -> void:
	set_animation()
	walk_direction()
	can_shoot()
	moving(delta)

func moving(delta):
	position += transform.x * speed * delta * direction


func _on_walk_timer_timeout() -> void:
	var idle_speed := 0
	animation.play("idle")
	idling = true
	speed = idle_speed
	idle_timer.start(2)


func _on_idle_timer_timeout() -> void:
	walk_timer.start(5)
	animation.play("walking")
	speed = normal_speed
	idling = false
	

func set_animation():
	if direction == -1:
		animation.flip_h = true
	if direction == 1:
		animation.flip_h = false

func walk_direction():
	if !foot_left.is_colliding():
		direction = 1
	if !foot_right.is_colliding():
		direction = -1

func can_shoot():
	var time = Time.get_ticks_msec()
	if vision_left.is_colliding() and direction == -1:
		if time - last_shot > shoot_cooldown:
			last_shot = time
			shoot()
	if vision_right.is_colliding() and direction == 1:
		if time - last_shot > shoot_cooldown:
			last_shot = time
			shoot()

func shoot():
	var laser = Laser.instantiate()
	get_tree().root.add_child(laser)
	if direction == 1:
		laser.global_transform = spawn_right.global_transform
	if direction == -1:
		laser.global_transform = spawn_left.global_transform
