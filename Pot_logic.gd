extends Node3D
@onready var pot_broken: Node3D = $Pot_Broken
@onready var pot_solid: Node3D = $Pot_solid
var intensity = 10

func _ready() -> void:
	pot_broken.set_process_mode(4)


func _on_area_3d_area_entered(area: Area3D) -> void:
	pot_broken.visible = true
	pot_broken.set_process_mode(0)
	pot_solid.visible = false
	
	brokening((global_position -area.global_position).normalized()*area.get_parent().speed)

#func _on_area_3d_body_entered(body: Node3D) -> void:
	#pot_broken.visible = true
	#pot_solid.visible = false

func brokening(stroke_vector: Vector3):
	
	for pieces:RigidBody3D in pot_broken.get_children():
		var random_directior: Vector3 = Vector3(randf(),randf(),randf()).normalized()
		var direction_vector: Vector3 =stroke_vector*random_directior
		pieces.apply_impulse(direction_vector, pot_broken.global_position);
	await get_tree().create_timer(8).timeout;
	queue_free();
