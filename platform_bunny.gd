extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var random_y := randi() % 1000 + 200
	position.y = random_y
