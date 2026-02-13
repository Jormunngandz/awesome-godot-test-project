class_name BasePickupData extends Resource


@export_group("Item Details")
@export var name: String = ""
@export var value: int
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var is_unique = false

#@export_group("Item Rendering")
##@export var texture: Texture
#@export var model: ArrayMesh

# Placeholder function - children will define behavior
func pick(_target):
	print(self, ": Used")
