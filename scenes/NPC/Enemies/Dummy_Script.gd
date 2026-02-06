extends CharacterBody3D

var player = null
const speed = 5.0

@export var player_path : NodePath

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	player = get_node(player_path)

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	navigation_agent_3d.set_target_position(player.global_position)
	print(player.global_position)
	var next_nav_point = navigation_agent_3d.get_next_path_position()
	velocity = (next_nav_point- global_position).normalized()*speed
	
	move_and_slide()
