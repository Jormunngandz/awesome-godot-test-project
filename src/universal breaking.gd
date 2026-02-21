extends Node3D

#универсальный скрипт подмены обьекта ломания
@onready var broken: Node3D = $"column-rigid"
@onready var solid: Node3D = $column_Rod2

#cкорость надо брать от снаряда и умножать на массу
var intensity = 10

func _ready() -> void:
	broken.set_process_mode(PROCESS_MODE_DISABLED)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent() is Projectile:
		
		var projectile = area.get_parent()
		if is_instance_of(projectile, Projectile):
			broken.visible = true
			broken.set_process_mode(PROCESS_MODE_INHERIT)
			solid.visible = false
			brokening((global_position -area.global_position).normalized()*projectile.projectile_data.speed)

#func _on_area_3d_body_entered(body: Node3D) -> void:
	#pot_broken.visible = true
	#pot_solid.visible = false

func brokening(stroke_vector: Vector3):
	
	for pieces:RigidBody3D in broken.get_children():
		pieces.mass = 100
		var random_directior: Vector3 = Vector3(randf(),randf(),randf()).normalized()
		var direction_vector: Vector3 =stroke_vector*random_directior
		pieces.apply_impulse(direction_vector, broken.global_position);
#надо реализовать что бы кусочки исчезали, а основа стояла
	#AWAIT GET_TREE().CREATE_TIMER(8).TIMEOUT;
	#QUEUE_FREE();
