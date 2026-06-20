extends Node2D
@onready var wheel: Sprite2D = $Wheel
var caninput:bool = true
var tempplayerspeed:float = 100
var speedmod:float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wheel.rotation_degrees -= tempplayerspeed*delta + speedmod#*playerdir
	if wheel.rotation_degrees >= 360: wheel.rotation_degrees = 0
	if wheel.rotation_degrees < 0: wheel.rotation_degrees = 360

func _input(event: InputEvent) -> void:
	if event.is_action("press") && caninput:
		caninput = false
		print(wheel.rotation_degrees)
		set_process(false)
		await get_tree().create_timer(0.1).timeout
		set_process(true)
		speedmod = randi_range(3,7)
		await get_tree().create_timer(0.1).timeout
		speedmod = 0
		caninput = true
		

func check_wheel_val(rotval):
	#if rotval
	pass
