extends Node2D
@onready var wheel: Sprite2D = $Wheel
@export var arrow: Sprite2D
@onready var player_body: RigidBody2D = $".."
var caninput:bool = true
#var tempplayerspeed:float = 100
var speedmod:float = 0
var consecutive_spins:int = 0

var options = [
	"SPEED UP", "SPEED DOWN",
	"BEACHBALL", "LEADBALL",
	"2X SCORE", "EXPLODE",
	"FLIPGRAV", "funnysound"]
#"SIZE UP", "SIZE DOWN",

func _input(event: InputEvent) -> void:
	if event.is_action("spin") && caninput:
		caninput = false
		LAND()
	if event.is_action_released("press"):
		rotation_degrees += 45
		

func LAND():
	#freeze game
	#zoom in
	var tween = create_tween()
	var wheelscale = create_tween()
	tween.tween_property(arrow,"offset:y",80,0.1)
	wheelscale.tween_property(wheel,"scale",Vector2(1,1),0.1)
	Sfxhandler.play(load("res://SFX/11C.wav"),self,1)
	await tween.finished
	Engine.call_deferred("set_time_scale",0.2)
	var tween2 = create_tween()
	var wheelscale2 = create_tween()
	tween2.tween_property(arrow,"offset:y",0,0.5)
	wheelscale2.tween_property(wheel,"scale",Vector2(0.57,0.57),0.1)
	check_wheel_val(global_rotation_degrees)
	#print(global_rotation_degrees)
	await get_tree().create_timer(0.2).timeout
	player_body.angular_velocity += randf_range(20,50) * player_body.dir
	caninput = true
	Engine.call_deferred("set_time_scale",1)

var colorlist = ["red","orange","yellow","green","cyan","blue","indigo","fushia"]

#does not work properly: issue with reading global_rotation_degrees
func check_wheel_val(rotval):
	var rotationv:int = int(rotval)
	if rotationv < 0: rotationv = abs(rotval*2)
	print(rotationv)
	for i in range(8):
		if rotationv >= (45*(i+1)) - 45 && rotationv <= 45 *(i+1):
			print(colorlist[i])
			print("WHEELVALUE")
			print(rotationv)
			print(i)
