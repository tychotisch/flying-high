extends Node2D

@onready var laser_spawn: Marker2D = $LaserSpawn

@onready var Laser := preload("res://objects/laser.tscn")



func shoot():
	var laser = Laser.instantiate()
	get_tree().root.add_child(laser)
	laser.global_transform = laser_spawn.global_transform


func _on_timer_timeout() -> void:
	shoot()
