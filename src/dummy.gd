extends CharacterBody3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var label_3d: Label3D = $Label3D
@onready var gpu_particles_3d_blood: GPUParticles3D = $GPUParticles3D_blood
@onready var character_body_3d: CharacterBody3D = $"."
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var area_3d_head: Area3D = $Area3D_head
@onready var _3_dm_dummy: Node3D = $"3dm_Dummy"

@onready var area_3d_body: Area3D = $Area3D_body
 

var isdead : bool =false
var player = null
const speed = 2.0
var dummy_hp =30 
@export var player_path : NodePath

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	label_3d.text = str(dummy_hp)

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	navigation_agent_3d.set_target_position(player.global_position)

	var next_nav_point_Y = navigation_agent_3d.get_next_path_position()
	var next_nav_point = Vector3(next_nav_point_Y.x,0,next_nav_point_Y.z)
	velocity = (next_nav_point- global_position).normalized()*speed
	look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z),Vector3.UP)
	#проверять HP Каждый тик? как то тупо
	if dummy_hp <=0:
		dead()
		
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	move_and_slide()
	
	
func dead():
	if isdead==false:
		isdead = true
		gpu_particles_3d_blood.emitting = true
		_3_dm_dummy.visible = false
		collision_shape_3d.disabled = true
		label_3d.visible = false
		area_3d_head.monitorable= false
		area_3d_body.monitorable= false
		audio_stream_player_3d.play()
	
	await get_tree().create_timer(3).timeout
	queue_free()
	

func _on_area_3d_body_area_entered(area: Area3D) -> void:
	dummy_hp -=5
	label_3d.text = str(dummy_hp)


func _on_area_3d_head_area_entered(area: Area3D) -> void:
	dummy_hp -=20 
	label_3d.text = str(dummy_hp)
