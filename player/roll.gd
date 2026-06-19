extends Node
@onready var player: Player = $".."
@onready var wall_detect: RayCast2D = $"../wall_detect"

var caninput = false

func enter_state():
	caninput = true

func _input(_event: InputEvent) -> void:
	var dir = Input.get_axis("left","right")
	if dir && caninput: player.change_speed(dir)

func handle_input(delta):
	#add gravity
	if !player.is_on_floor():
		player.velocity.y += player.gravity*delta
	
	var target_speed = (player.base_speed + player.speedmod) * player.dir
	
	player.velocity.x = move_toward(player.velocity.x,target_speed,delta*1000)
	
	player.sprite.rotation_degrees += player.velocity.x*delta
	if player.sprite.rotation_degrees >= 360: player.sprite.rotation_degrees = 0
	if player.sprite.rotation_degrees < 0: player.sprite.rotation_degrees = 360
	
	if wall_detect.is_colliding():
		player.change_state("bounce")

func exit_state():
	caninput = false
