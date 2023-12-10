extends Area2D

@onready var coin_bronze: Area2D = $"."
var random_y_pos := randi() % 1300 + 200

func _ready() -> void:
	randomize()
	coin_bronze.global_position.y = random_y_pos

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Events.emit_signal("coin_picked", 10)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
