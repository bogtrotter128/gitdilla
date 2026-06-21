extends RigidBody2D
@onready var sprite: Sprite2D = $sprite
@onready var floor_detect: RayCast2D = $"../player_parts/floor_detect"

var dir = 1
var speed = 800

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	apply_central_force(Vector2(speed*dir,0))

func _physics_process(_delta: float) -> void:
	if linear_velocity.x <0: change_speed(-1)
	else: change_speed(1)

func change_speed(setdir):
	#sprite.flip_h = false if setdir > 0 else true
	dir = setdir
	#apply_central_impulse(Vector2(100*dir,0))

func launch(vector:Vector2):
	linear_velocity = Vector2.ZERO
	angular_velocity = vector.length()/10
	print("VECTOR" + str(angular_velocity))
	apply_impulse(vector*10)
	#if vector.x <0: change_speed(-1)
	#else: change_speed(1)

func _on_drag_area_vector_created(vector: Variant) -> void:
	launch(vector)
