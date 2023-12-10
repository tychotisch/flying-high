extends Node2D

@onready var player: CharacterBody2D = $"../Player"

var rock_waterfall := preload("res://obstacles/RockWaterfall.tscn")
var laser_station := preload("res://objects/laser_station.tscn")
#var wing_man := preload("res://enemies/wing_man.tscn")
var platform_bunny := preload("res://objects/platform.tscn")
var swinging_rock := preload("res://objects/rope.tscn")

var flying_list := [platform_bunny, rock_waterfall]

var coin_bronze := preload("res://obstacles/coinBronze.tscn")
var coin_counter := 1
var counter := 1
var spacing := 750
var coin_spacing := 500
var random_number := 0
var amount := 3

#func _physics_process(_delta: float) -> void:
#	if player.position.x > (spacing * counter) - 1000:
#		spawn_random_object()
#	if player.position.x > (coin_spacing * coin_counter) - 800:
#		spawn_coin()

func _ready() -> void:
	randomize()
	for i in 50:
		random_number = randi() % 5 + 1
		spawn_random_object()
		spawn_coin()
	#spawn_random_object()

func spawn_random_object():
	if random_number == 1:
		spawn_flying_objects()
	if random_number == 2:
		spawn_ceiling_objects()
	if random_number == 3:
		spawn_ground_objects()
	if random_number == 4:
		spawn_flying_objects()

func spawn_coin():
	var coin = coin_bronze.instantiate()
#	get_tree().root.add_child.call_deferred(coin)
	add_child(coin)
	coin_counter += 1
	coin.position.x = coin_spacing * coin_counter

func spawn_ceiling_objects():
	var obstacle = swinging_rock.instantiate()
#	get_tree().root.add_child.call_deferred(obstacle)
	add_child(obstacle)
	counter += 1
	obstacle.position.y = 155
	obstacle.position.x = spacing * counter

func spawn_ground_objects():
	var obstacle = laser_station.instantiate()
	add_child(obstacle)
#	get_tree().root.add_child.call_deferred(obstacle)
	counter += 1
	obstacle.position.x = spacing * counter
	obstacle.position.y = 1558

func spawn_flying_objects():
	#random y is handled by the flying scripts
	var obstacle_type = flying_list[randi() % flying_list.size()]
	var obstacle_to_place = obstacle_type.instantiate()
#	get_tree().root.add_child.call_deferred(obstacle_to_place)
	add_child(obstacle_to_place)
	counter += 1
	obstacle_to_place.position.x = spacing * counter

func _on_timer_timeout() -> void:
	random_number = randi() % 5 + 1
