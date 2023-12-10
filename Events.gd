extends Node

# Auto-loaded node that only emits signals.
# Any node in the game can use it to emit signals, like so:
		# Events.emit_signal("mob_died", 10)

# Any node in the game can connect to the events:
	# #Events.connect("mob_died", update_score)

# This allows nodes to easily communicate accross the project without needing to
# know about each other. We mainly use it to update the heads-up display, like
# the player's health and score.


signal coin_picked(value)
signal end_of_area
signal player_hit
signal rock_hit
signal restart_game
