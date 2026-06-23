extends RigidBody2D
@onready var sprite: Sprite2D = $Sprite2D
const SHARD_EMITTER = preload("uid://cr1ecv4ltf3u3")

enum material_type {GLASS, WOOD,STONE}
@export var material_strength = material_type.WOOD
var HEALTH:int = 500

func _ready() -> void:
	add_to_group("enemy")
	HEALTH += 500 * material_strength

func damage(vel_dmg:Vector2):
	if vel_dmg.length() > 500:
		HEALTH -= int(vel_dmg.length())
	if HEALTH <= 0:
		die()

func die():
	if has_node("CollisionShape2D"):
		$CollisionShape2D.call_deferred("set_disabled",true)
	else:
		$CollisionPolygon2D.call_deferred("set_disabled",true)
	call_deferred("set_freeze_enabled",true)
	var shards = SHARD_EMITTER.instantiate()
	sprite.add_child(shards)
