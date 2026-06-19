extends RigidBody2D
@onready var sprite: Sprite2D = $sprite
@onready var floor_detect: RayCast2D = $"../player_parts/floor_detect"

var dir = 1
var speed = 800

func _input(_event: InputEvent) -> void:
	var dir = Input.get_axis("left","right")
	if dir: change_speed(dir)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	apply_central_force(Vector2(speed*dir,0))

func change_speed(setdir):
	sprite.flip_h = false if setdir > 0 else true
	dir = setdir
	if floor_detect.is_colliding():
		apply_central_force(Vector2(0,-550))
