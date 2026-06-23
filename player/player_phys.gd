extends RigidBody2D
@onready var player: Player = $".."
@onready var sprite: Sprite2D = $sprite
@onready var floor_detect: RayCast2D = $"../player_parts/floor_detect"
@onready var launch_cooldown: Timer = $"../launch_cooldown"

var launch_fatigue = 1
var dir = 1
var speed = 800
var bouncestrengthmin:float = 0.6

const sfxlist =[
	"res://SFX/bounce_light.wav",
	"res://SFX/bounce_heavy.wav",
	"res://SFX/stone_light.wav",
	"res://SFX/stone_heavy.wav",
]

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	apply_central_force(Vector2(speed*dir,0))

func _physics_process(_delta: float) -> void:
	if linear_velocity.x <0: change_speed(-1)
	else: change_speed(1)

func change_speed(setdir):
	dir = setdir

func launch(vector:Vector2):
	play_sfx("res://SFX/rubber_band_snap.ogg")
	var launch_str:Vector2 = (vector*10/launch_fatigue).limit_length(1500)/launch_fatigue
	linear_velocity = Vector2.ZERO
	angular_velocity = (launch_str.length()/100)
	print("VECTOR" + str(angular_velocity))
	apply_impulse(launch_str)
	physics_material_override.bounce = 0.7
	launch_fatigue += 0.5
	launch_cooldown.start()

func _on_drag_area_vector_created(vector: Variant) -> void:
	launch(vector)

func _on_body_entered(_body: Node) -> void:
	#if player.phys_property == 0:
	play_sfx("res://SFX/hit3.wav")
	if physics_material_override.bounce > bouncestrengthmin:
		physics_material_override.bounce -= 0.5
	else:
		physics_material_override.bounce = bouncestrengthmin
	launch_fatigue = 1
	launch_cooldown.stop()


func play_sfx(sfx:String):
	var pitch = randf_range(0.9,1.1)
	Sfxhandler.play(load(sfx),self,pitch)


func _on_speed_up_timer_timeout() -> void:
	if speed < 2000:
		speed += 10
	else:
		$"../speed_up_timer".stop()


func _on_launch_cooldown_timeout() -> void:
	launch_fatigue = 1
