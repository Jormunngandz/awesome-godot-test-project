extends Node3D
var intensity = 2
func _ready() -> void:
	for pieces:RigidBody3D in self.get_children():
		pieces.apply_impulse(pieces.position * intensity, self.global_position);;
		print(pieces.get_child(0).global_position)
	await get_tree().create_timer(15).timeout;
	queue_free();
