extends Node3D

@export var audio_player: AudioStreamPlayer3D
@export var stats: BasePickupData
@export var model: Node3D
@export var area: Area3D
const SPEED:float = 0.01
const AMPLITUDE:float = 0.002
var time: float = 0.0 
var frequency: float = 2.0
var picked_status: bool = false

func _process(delta: float) -> void:
	time += delta
	model.rotation.y += deg_to_rad(1)
	var y_offset = sin(time * frequency) * AMPLITUDE
	model.global_position.y += y_offset

func _ready() -> void:
	area.body_entered.connect(body_entered)
	
func body_entered(body: Node3D) -> void:
	if stats.has_method("pick") and stats.pick(body) and not picked_status:
		picked_status = true
		visible = false
		if audio_player:
			audio_player.play()
			await audio_player.finished
		queue_free()
	
