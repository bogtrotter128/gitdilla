extends CharacterBody2D
class_name Player
@onready var sprite: Sprite2D = $sprite

var gravity = 5000
var base_speed:float = 500
var speedmod:float = 1
var dir = 1

var current_state

func _ready() -> void:
	change_state("roll")

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.handle_input(delta)

func change_speed(setdir):
	sprite.flip_h = false if setdir > 0 else true
	velocity.y -= 800
	dir = setdir

func change_state(state:String):
	if current_state: current_state.exit_state()
	current_state = get_node(state)
	current_state.enter_state()


func _on_speed_increase_timer_timeout() -> void:
	speedmod += 1
