extends Node

const GUI = preload("res://levels/gui/GUI.tscn")
const WORLD = preload("res://scenes/world.tscn")

func _ready() -> void:
	var gui_node = GUI.instantiate()
	add_child(gui_node)
	Messager.connect("load_level", load_test_level)


func load_test_level():
	var new_test_level = WORLD.instantiate()
	add_child(new_test_level)
