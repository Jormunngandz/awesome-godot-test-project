class_name Projectile
extends Node3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $Area3D/AudioStreamPlayer3D
@onready var skull: Node3D = $Area3D/Skull
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var gpu_particles_3d: GPUParticles3D = $Area3D/GPUParticles3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



var speed=10
var damage = 10
var live_time = 3
var is_dying :bool =false
func _ready():
	pass#gpu_particles_3d.
	
func _physics_process(delta):
	position += transform.basis * Vector3(0,speed,0) * delta
	#таймер жизни снаряда
	await get_tree().create_timer(live_time).timeout
	SelfDestruct()

func SelfDestruct():
	if is_dying == false:
		is_dying = true
		queue_free()
		
func Damage_Destruct():
	#Функция униxтожения снаряда при столкновении
	#проверка отсутствия одновременного умирания. на случай рахных анимаций в разных условиях
	if is_dying == false:
		is_dying = true
			#удаляем колизию и модельку 
		animation_player.play("Hit")
		#skull.visible = false
		##партикли взрыв
		#gpu_particles_3d.emitting = true
		#включаем звук. проверка что звука нет
		

		#await animation_player.animation_finished
	#уничтожаем снаряд 
		#queue_free()
		print("череп удален")




func _on_area_3d_body_entered(body: Node3D) -> void:
	Damage_Destruct()
	
	surface_sound(body)
	
	
	#print("череп столкнулся c телом") 


func _on_area_3d_area_entered(area: Area3D) -> void:
	Damage_Destruct()
	audio_stream_player_3d.stream = load("res://assets/Environment/materials/materials sound/Soft Body Impact.mp3")
	audio_stream_player_3d.play()
	print("звук мяса")
	#print("череп столкнулся c зоной") 
	
func surface_sound(body: Node3D):
	if body.is_in_group("metal_object"):
		audio_stream_player_3d.stream = load("res://assets/Environment/materials/materials sound/Metal_Hit.mp3")
		audio_stream_player_3d.play()
		print("звук метала")
	elif body.is_in_group("wood_object"):
		audio_stream_player_3d.stream = load("res://assets/Environment/materials/materials sound/Wood_Hit.mp3")
		audio_stream_player_3d.play()
		print("звук дерева")
	else:
		audio_stream_player_3d.stream = load("res://assets/weapon/skull_gun/xbow_hitbod2.wav")
		audio_stream_player_3d.play()
		print("звук просто")
