extends Node3D



var speed=10

	
func _ready():
	pass
	
func _physics_process(delta):
	position += transform.basis * Vector3(0,speed,0) * delta

	
