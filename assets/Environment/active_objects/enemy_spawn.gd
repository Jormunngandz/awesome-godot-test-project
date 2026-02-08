extends Node3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@export var enemy = preload("res://assets/enemies/dummy.tscn")
@onready var marker_3d: Marker3D = $marker_3d

var enemy_instance
func _physics_process(delta: float) -> void:
	if get_tree().get_nodes_in_group("Enemy").is_empty():
		enemy_instance = enemy.instantiate()

		enemy_instance.position = marker_3d.global_position
		enemy_instance.transform.basis = marker_3d.global_transform.basis
		enemy_instance.add_to_group("Enemy")
		get_tree().root.add_child(enemy_instance)
		
		print("ребенок вызван")
		await get_tree().create_timer(5).timeout
	mesh_instance_3d.rotation.y += deg_to_rad(1)
	
	
