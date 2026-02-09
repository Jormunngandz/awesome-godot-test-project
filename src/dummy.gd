extends CharacterBody3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_3d: Label3D = $Label3D
@onready var gpu_particles_3d_blood: GPUParticles3D = $GPUParticles3D_blood
@onready var character_body_3d: CharacterBody3D = $"."
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var area_3d_head: Area3D = $Area3D_head
@onready var _3_dm_dummy: Node3D = $"3dm_Dummy"

@onready var area_3d_body: Area3D = $Area3D_body

var alive: bool = true
var player:CharacterBody3D = null
const movement_speed:float = 2.0
const MAX_SPEED: float = 5.0
var dummy_hp = 30 
@export var player_path : NodePath

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	label_3d.text = str(dummy_hp)
	navigation_agent_3d.max_speed = MAX_SPEED
func _physics_process(delta: float) -> void:

	
		# Do not query when the map has never synchronized and is empty.
	navigation_agent_3d.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navigation_agent_3d.get_next_path_position()
	#print("player"+ str(player.global_position))
	#
	velocity = global_position.direction_to(next_path_position) * Vector3(movement_speed,0,movement_speed)
	#velocity = Vector3(velocity.x,0,velocity.z)
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
	
	
	
	#navigation_agent_3d.set_target_position(player.global_position)
	#if navigation_agent_3d.is_navigation_finished():
		#return
	#var next_nav_point_Y = navigation_agent_3d.get_next_path_position()
	#var next_nav_point = Vector3(next_nav_point_Y.x,0,next_nav_point_Y.z)
	#velocity = (next_nav_point- global_position).normalized()*SPEED
	#var look_at_pos = Vector3(next_nav_point.x, global_position.y, next_nav_point.z)
	#if not global_position.is_equal_approx(look_at_pos):
		#look_at(look_at_pos,Vector3.UP)
	#move_and_slide()
		
	
func dead():
	if alive:
		alive = false
		animation_player.play("dead")
		
	

func _on_area_3d_body_area_entered(area: Area3D) -> void:
	dummy_hp -=5
	label_3d.text = str(dummy_hp)
	if dummy_hp <=0:
		dead()


func _on_area_3d_head_area_entered(area: Area3D) -> void:
	dummy_hp -=20 
	label_3d.text = str(dummy_hp)
	if dummy_hp <=0:
		dead()
