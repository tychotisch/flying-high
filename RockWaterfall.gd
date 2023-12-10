extends Node2D

@onready var rock := preload("res://objects/rock.tscn")
@onready var timer: Timer = $Timer

var amount_to_spawn := 3	

func spawn_rocks():
	for i in amount_to_spawn:
		var rock_to_spawn = rock.instantiate()
		add_child(rock_to_spawn)

func _on_timer_timeout() -> void:
	spawn_rocks()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

