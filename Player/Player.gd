extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var character_camera_3d: Camera3D = $Head/Character_Camera3D
@onready var collision_crouch: CollisionShape3D = $Collision_Crouch
@onready var collision_stand: CollisionShape3D = $Collision_Stand
@onready var ray_cast_3d: RayCast3D = $RayCast3D


#Константы
const WALKING_SPEED = 5.0
const SPRINTING_SPEED = 20.0
const CROUCH_SPEED = 1.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS =0.4

#переменные 
var current_speed : float = 5.0
var Lerp_Speed = 10
var direction = Vector3.ZERO

#state machine
var Walking : bool =false
var Sprinting : bool =false
var Crouching : bool =false
var Sliding : bool = false

#Slide Vars
var Slide_Timer =0.0
var Slide_Timer_Max =3.0
var Slide_Vector = Vector2.ZERO
var Slide_Speed = 30

func _ready() -> void:
	# отключаем курсор мыши 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))
			# проверяем нажание кнопок. выглядит ужасно 

		
func _physics_process(delta: float) -> void:
		# Get the input direction and handle the movement/deceleration.
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		# машина состояний
		# проверяем нажание кнопок. выглядит ужасно 
	if Input.is_action_just_pressed("Crouch") and !Sprinting:
		Walking =false
		Sprinting =false
		Crouching =true
		Sliding = false
		#print(" КРАДЕМСЯ")
	elif Input.is_action_just_pressed("Crouch") and Sprinting:
		#print("CКОЛЬЗИМ")
		Slide_Timer = Slide_Timer_Max
		Walking =false
		Sprinting =false
		Crouching =true
		Sliding = true
	if Input.is_action_just_released("Crouch"):
		#print("не КРАДЕМСЯ")
		Walking =true
		
		Crouching =false
		Sliding = false
	if Input.is_action_just_pressed("Sprint"):
		Walking =false
		Sprinting =true
		Crouching =false
		Sliding = false
		#print("БЕЖИМ")
	if Input.is_action_just_released("Sprint"):
		#print("не бежим")
		Walking =true
		Sprinting =false
		Crouching =false
		Sliding = false
		
	if   !Crouching and !Sliding and !Sprinting:
		Sprinting = false
		Walking =true
		Crouching =false
		Sliding = false
		#print("ходим")
	
	
	#логика присидания
	if Crouching:
		current_speed = lerp(current_speed,CROUCH_SPEED,delta*Lerp_Speed)
		head.position.y =  lerp(head.position.y,1.0,delta*Lerp_Speed)
		collision_stand.disabled = true
		collision_crouch.disabled = false
#этот кусок кода востанавливает скорость ходьбы после бега. не логично. надо бы его отдельно вынести 
	elif !ray_cast_3d.is_colliding() and !Crouching:
		
		head.position.y = lerp(head.position.y,1.85,delta*Lerp_Speed)
		collision_stand.disabled = false
		collision_crouch.disabled = true
			
	#логика бега
	if  Sprinting:
		current_speed = lerp(current_speed,SPRINTING_SPEED,delta*Lerp_Speed)
		
		#нормализация скорости ходьбы
	if Walking:
		current_speed = lerp(current_speed,WALKING_SPEED,delta*Lerp_Speed)

#Sliding logic
	if Sliding:
		current_speed = (Slide_Timer+0.1)*Slide_Speed
		Slide_Timer -=delta
		
		#print(Slide_Timer)
		if Slide_Timer <= 0:
			Sliding=false
			Crouching =false
			Slide_Timer = 0
			#print("slide END")
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#высота прыжка зависит от скорости 
		velocity.y = JUMP_VELOCITY+(0.1*current_speed)


	#direction определяет направление 
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*Lerp_Speed)
	
	#логика запрета поворота при подкате
	#if Sliding:
	#	direction = transform.basis * Vector3(Slide_Vector.x,0,Slide_Vectorц.y).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
	
	else:
		#print("обычная скорость")
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	#print(current_speed)
	move_and_slide()
