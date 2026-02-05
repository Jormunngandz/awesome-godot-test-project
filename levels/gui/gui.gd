extends Control

const MAINMENU = preload("res://levels/gui/MainMenu.tscn")
const INGAMEMENU = preload("res://levels/gui/in_game_menu.tscn")
var menu:Control


func _ready() -> void:
	menu = MAINMENU.instantiate()
	Messager.connect("load_level", on_load_level)
	Messager.connect("resume", on_resume_game)
	Messager.connect("back_to_main_menu", on_back_to_main_menu)
	add_child(menu)


func on_load_level():
	menu.queue_free()
	
	
func on_resume_game():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	menu.queue_free()


func on_back_to_main_menu():
	get_tree().paused = false
	get_tree().reload_current_scene()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		
		if not menu:
			menu = INGAMEMENU.instantiate()
			add_child(menu)	
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif menu.ui_state == menu.MENUSTATES.MENU and menu.get_scene_file_path() == "res://levels/gui/in_game_menu.tscn":
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			menu.queue_free()
			get_tree().paused = false
