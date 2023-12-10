extends Node2D


@onready var boulder: RigidBody2D = $Boulder
var force := 250
@onready var remove_obstacle_timer: Timer = $RemoveObstacleTimer

func _ready() -> void:
	boulder.apply_central_force(Vector2(200, 0) * force)

func _on_collider_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Events.emit_signal("player_hit")




func _on_timer_timeout() -> void:
	boulder.apply_central_force(Vector2(200, 0) * force)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	remove_obstacle_timer.start()
	


func _on_remove_obstacle_timer_timeout() -> void:
	queue_free()
