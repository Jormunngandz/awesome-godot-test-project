class_name Projectile
extends Node3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $Area3D/AudioStreamPlayer3D
@onready var skull: Node3D = $Area3D/Skull
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var gpu_particles_3d: GPUParticles3D = $Area3D/GPUParticles3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var self_destruct_timer: Timer = %SelfDestructTimer

var speed=10
var damage = 10
var live_time = 3
var is_dying: bool = false
func _physics_process(delta):
	position += transform.basis * Vector3(0,speed,0) * delta


func hit(hitted_obj: Node3D):
	set_player_sound(hitted_obj)
	animation_player.play("Hit")
	await  animation_player.animation_finished


#func _on_area_3d_body_entered(body: Node3D) -> void:
	#hit(body)
	#if body.has_method("hit"):
		#body.hit(self, body)
	

func _on_area_3d_area_entered(area: Area3D) -> void:
	hit(area)
	if area.get_parent().has_method("hit"):
		area.get_parent().hit(self, area)
	
	
func set_player_sound(obj: Node3D):
	if obj.is_in_group("metal_object"):
		audio_stream_player_3d.stream = load("res://assets/sounds/materials sound/Metal_Hit.mp3")
	elif obj.is_in_group("wood_object"):
		audio_stream_player_3d.stream = load("res://assets/sounds/materials sound/Wood_Hit.mp3")
	elif obj.is_in_group("Enemy"):
		audio_stream_player_3d.stream = load("res://assets/sounds/materials sound/Soft Body Impact.mp3")
	else:
		audio_stream_player_3d.stream = load("res://assets/sounds/materials sound/default_hit.wav")
	audio_stream_player_3d.play()


func _on_self_destruct_timer_timeout() -> void:
	queue_free()


func _on_area_3d_body_shape_entered(_body_rid: RID, body: Node3D, body_shape_index: int, _local_shape_index: int) -> void:
	hit(body)
	if body.has_method("hit"):
		var collision_part: CollisionShape3D = body.find_children("CollisionShape3D*")[body_shape_index]
		body.hit(self, collision_part)
