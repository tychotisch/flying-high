extends CharacterBody2D

@onready var Laser := preload("res://objects/laser.tscn")
@onready var spawn_0: Marker2D = $SpawnLeft
@onready var spawn_1: Marker2D = $SpawnMiddle
@onready var spawn_2: Marker2D = $SpawnRight
@onready var pos_spawn := [spawn_0, spawn_1, spawn_2]




var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -500

func _ready() -> void:
	randomize()
	var random_y := randi() % 1100 + 800
	position.y = random_y

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		apply_gravity(delta)
		move_and_slide()


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta


func jump():
	velocity.y = JUMP_VELOCITY

func _on_flap_timer_timeout() -> void:
	jump()


func shoot():
	var spawn_pos = pos_spawn[randi() % pos_spawn.size()]
	var laser = Laser.instantiate()
	get_tree().root.add_child(laser)
	laser.speed = 1000
	laser.global_transform = spawn_pos.global_transform
	

func _on_shoot_timer_timeout() -> void:
	shoot()
#
