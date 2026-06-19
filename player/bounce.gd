extends Node
@onready var player: Player = $".."

func enter_state():
	var tempv = player.velocity
	player.velocity = Vector2.ZERO
	await get_tree().create_timer(0.1).timeout
	player.velocity = tempv
	player.velocity += Vector2(tempv.x*-2, -abs(tempv.x)) + Vector2(250*-player.dir,-250)
	player.dir *= -1
	player.change_state("roll")

func handle_input(delta):
	pass

func exit_state():
	pass
