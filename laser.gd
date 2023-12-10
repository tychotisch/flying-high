extends Area2D

@export var speed := 1300
@export var direction := 1

func _physics_process(delta):
	position -= transform.y * speed * delta * direction


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Events.emit_signal("player_hit")
		queue_free()
	if body.has_method("remove_rock"):
		body.remove_rock()
		queue_free()
	queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
