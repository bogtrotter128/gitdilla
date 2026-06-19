extends Node
@onready var player: Player = $".."

func enter_state():
	#var tempv = player.velocity
	#player.velocity = Vector2.ZERO
	player.change_speed(-player.dir)
	#await get_tree().create_timer(0.1).timeout
	#player.velocity = tempv
	#player.velocity += Vector2(tempv.x,-200)
	player.change_state("roll")

func handle_input(delta):
	pass

func exit_state():
	pass
