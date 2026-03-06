extends Node3D

#универсальный скрипт подмены обьекта ломания
@export var broken: Node3D
@export var solid: Node3D
@export var area: Area3D
#cкорость надо брать от снаряда и умножать на массу
@export var intensity: int
@export var pieces_mass: int = 10
func _ready() -> void:
	broken.set_process_mode(PROCESS_MODE_DISABLED)
	#solid.set_process_mode(PROCESS_MODE_DISABLED)
	#area.area_entered.connect(proccess_destruction)
	broken.visible = false

func proccess_destruction(object: Area3D) -> void:
	print(self, " hitted by: ", object.get_parent())
	if object.get_parent() is Projectile and solid:
		var projectile = object.get_parent()
		if is_instance_of(projectile, Projectile):
			broken.visible = true
			broken.set_process_mode(PROCESS_MODE_INHERIT)
			solid.queue_free()
			brokening((global_position -object.global_position).normalized()*projectile.projectile_data.speed)

#func _on_area_3d_body_entered(body: Node3D) -> void:
	#pot_broken.visible = true
	#pot_solid.visible = false

func brokening(stroke_vector: Vector3):
	
	for pieces:RigidBody3D in broken.get_children():
		pieces.mass = pieces_mass
		var random_directior: Vector3 = Vector3(randf(),randf(),randf()).normalized()
		var direction_vector: Vector3 =stroke_vector*random_directior
		pieces.apply_impulse(direction_vector, broken.global_position);
#надо реализовать что бы кусочки исчезали, а основа стояла
	#AWAIT GET_TREE().CREATE_TIMER(8).TIMEOUT;
	#QUEUE_FREE();
