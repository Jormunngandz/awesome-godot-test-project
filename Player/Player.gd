extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var character_camera_3d: Camera3D = $Head/Character_Camera3D
@onready var collision_crouch: CollisionShape3D = $Collision_Crouch
@onready var collision_stand: CollisionShape3D = $Collision_Stand
@onready var ray_cast_3d: RayCast3D = $RayCast3D


const WALKING_SPEED = 5.0
const SPRINTING_SPEED = 15.0
const CROUCH_SPEED = 2.0
const JUMP_VELOCITY = 4.5

var Current_Speed = 5.0

const MOUSE_SENS =0.4
var Lerp_Speed = 10
var direction = Vector3.ZERO
func _ready() -> void:
	# отключаем курсор мыши 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))
		
func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("Crouch"):
		Current_Speed = lerp(Current_Speed,CROUCH_SPEED,delta*Lerp_Speed)
		head.position.y =  lerp(head.position.y,1.0,delta*Lerp_Speed)
		collision_stand.disabled = true
		collision_crouch.disabled = false
	elif !ray_cast_3d.is_colliding():
		head.position.y = lerp(head.position.y,1.85,delta*Lerp_Speed)
		collision_stand.disabled = false
		collision_crouch.disabled = true
	if Input.is_action_pressed("Sprint"):
		Current_Speed = lerp(Current_Speed,SPRINTING_SPEED,delta*Lerp_Speed)
	else:
		Current_Speed =  lerp(Current_Speed,WALKING_SPEED,delta*Lerp_Speed)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#высота прыжка зависит от скорости 
		velocity.y = JUMP_VELOCITY+(0.1*Current_Speed)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*Lerp_Speed)
	if direction:
		velocity.x = direction.x * Current_Speed
		velocity.z = direction.z * Current_Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Current_Speed)
		velocity.z = move_toward(velocity.z, 0, Current_Speed)

	move_and_slide()
