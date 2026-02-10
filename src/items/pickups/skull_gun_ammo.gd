extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D
@export var stats: AmmoData
const SPEED:float = 0.01
const AMPLITUDE:float = 0.002
var time: float = 0.0 
var frequency: float = 2.0
func _process(delta: float) -> void:
	time += delta
	rotation.y += deg_to_rad(1)
	var y_offset = sin(time * frequency) * AMPLITUDE
	global_position.y += y_offset


func _on_area_3d_body_entered(body: Node3D) -> void:
	if stats.use(body):
		queue_free()
	
