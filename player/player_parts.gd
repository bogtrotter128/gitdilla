extends Node2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var player_parts: Node2D = $player_parts


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_parts.global_position = rigid_body_2d.global_position
