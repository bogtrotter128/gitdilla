extends Node2D
@onready var body: RigidBody2D = $RigidBody2D
@onready var player_parts: Node2D = $player_parts

enum properties {NORMAL,BEACH,LEAD,GOLD}
@export var phys_property = properties.NORMAL

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
	player_parts.global_position = body.global_position

func set_properties(preset):
	body.mass = preset.get("mass")
	body.physics_material_override.bounce = preset.get("bounce")
	body.physics_material_override.friction = preset.get("friction")
	print("mass: " + str(preset.get("mass")))
	print("bounce: " + str(preset.get("bounce")))
	print("friction: " + str(preset.get("friction")))
