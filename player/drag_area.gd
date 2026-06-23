extends Area2D
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer

signal vector_created(vector)

var interact:bool = false
var touchdown = false

var pos_start = Vector2.ZERO
var pos_end = Vector2.ZERO
const max_length = 200
var vector = Vector2.ZERO

@export var slow_time:bool = true
@export var slowtimedelta:float = 0.1

func _input(event: InputEvent) -> void:
	if event.is_action_released("press") && touchdown:
		touchdown = false
		emit_signal("vector_created",vector)
		reset()
	
	if event.is_action_pressed("press") && interact:
		touchdown = true
		#pos_start = get_local_mouse_position()
		time_scale(0.4)
		Sfxhandler.play(load("res://SFX/charge_small.wav"),self,1)

	if event is InputEventMouseMotion && touchdown:
		pos_end = get_local_mouse_position()
		#get_global_mouse_position()
		vector = -(pos_end - pos_start).limit_length(max_length)
		if !sfx.playing: sfx.play()
		queue_redraw()


func _draw() -> void:
	draw_line(pos_start,pos_end,Color(0.0, 0.0, 0.839, 1.0),8)
	
	draw_line(pos_start+vector,pos_end+vector,Color(0.503, 0.102, 0.127, 1.0),16)
	print(vector)

func reset():
	pos_start = Vector2.ZERO
	pos_end = Vector2.ZERO
	vector = Vector2.ZERO
	time_scale(1)
	queue_redraw()


func _on_mouse_entered() -> void:
	interact = true

func _on_mouse_exited() -> void:
	interact = false

func time_scale(time):
	var timetween = create_tween()
	timetween.tween_property(Engine,"time_scale",time,slowtimedelta)
