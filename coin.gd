extends Area2D

@onready var coin: Area2D = $"."



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Events.emit_signal("coin_picked", 10)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
