extends RigidBody2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionPolygon2D = $CollisionPolygon2D
@export var sprite_texture:Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite_texture: sprite.texture = sprite_texture
	var image = Image.new()
	image.load(sprite.texture.resource_path)

	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0,0), bitmap.get_size()))

	for polygon in polygons:
		collider.polygon = polygon
		collider.position -= Vector2(bitmap.get_size()/2.0)
