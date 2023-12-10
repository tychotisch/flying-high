extends Node2D

@onready var ground := preload("res://background/ground.tscn")

var multiplier_ground := 2500
var counter := 0
var ground_height := 1335

func _ready() -> void:
	Events.connect("restart_game", restart_game)

func _process(_delta: float) -> void:
	ground_position()

func ground_position():
	if $Player.position.x > multiplier_ground * counter - 1000:
		spawn_ground()
#	if $Player.position.x < -multiplier_ground * counter + 450:
#		spawn_ground_negative()

func spawn_ground():
	var ground_to_spawn = ground.instantiate()
	add_child(ground_to_spawn)
	counter += 1
	ground_to_spawn.position.x = multiplier_ground * counter
	ground_to_spawn.position.y = ground_height

#func spawn_ground_negative():
#	var ground_to_spawn = ground.instantiate()
#	add_child(ground_to_spawn)
#	counter += 1
#	ground_to_spawn.position.x = -multiplier_ground * counter
#	ground_to_spawn.position.y = ground_height

func restart_game():
	get_tree().reload_current_scene()
	
	
