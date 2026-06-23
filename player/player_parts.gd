extends Node2D
class_name Player
@onready var player_body: RigidBody2D = $RigidBody2D
@onready var player_parts: Node2D = $player_parts
@onready var camera: Camera2D = $player_parts/Camera2D

enum properties {NORMAL,BEACH,LEAD,GOLD}
@export var phys_property = properties.NORMAL
var zoomval:float = 1.0

const phys_presets:Dictionary = {
	"normal": {
		"mass"= 1.0,
		"bounce"= 0.3,
		"friction" = 1},
	"beach": {
		"mass"= 0.7,
		"bounce"= 0.6,
		"friction" = 1},
	"lead": {
		"mass"= 2,
		"bounce"= 0.2,
		"friction" = 1},
	"gold": {
		"mass"= 10,
		"bounce"= 0,
		"friction" = 1},
}

func _ready() -> void:
	var test:String = properties.keys()[phys_property]
	set_properties(phys_presets.get(test.to_lower()))

func _process(delta: float) -> void:
	player_parts.global_position = player_body.global_position

func set_properties(preset):
	player_body.mass = preset.get("mass")
	player_body.physics_material_override.bounce = preset.get("bounce")
	player_body.physics_material_override.friction = preset.get("friction")
	player_body.bouncestrengthmin = preset.get("bounce")
	print("mass: " + str(preset.get("mass")))
	print("bounce: " + str(preset.get("bounce")))
	print("friction: " + str(preset.get("friction")))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton: #zoom in/out
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom(0.1)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom(-0.1)

func zoom(delta):
	zoomval += delta
	zoomval = clampf(zoomval,0.1,3)
	camera.zoom = Vector2(zoomval,zoomval)


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damage(player_body.linear_velocity)
