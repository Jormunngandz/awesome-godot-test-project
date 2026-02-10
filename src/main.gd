extends Node

const GUI = preload("res://assets/gui/gui.tscn")
const WORLD = preload("res://assets/world/world.tscn")
var player: CharacterBody3D
func _ready() -> void:
	var gui_node = GUI.instantiate()
	add_child(gui_node)
	Messager.connect("load_level", load_level)


func load_level():
	var new_test_level = WORLD.instantiate()
	add_child(new_test_level)
	player = get_tree().get_first_node_in_group("Player")
