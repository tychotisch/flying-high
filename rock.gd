extends RigidBody2D

class_name Rock

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_colider_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Events.emit_signal("player_hit")
		queue_free()
