extends Node3D

@onready var spot_light_3d: SpotLight3D = %SpotLight3D
@onready var omni_light_3d: OmniLight3D = %OmniLight3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var turn_on = false

func turn_off_on():

	if not animation_player.is_playing():
		if turn_on:
			animation_player.play_backwards("rise")
		else:
			animation_player.play("rise")
		await  animation_player.animation_finished
		turn_on = not turn_on
			
		
	
