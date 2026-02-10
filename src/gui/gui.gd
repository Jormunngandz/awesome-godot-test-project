extends Control

const MAINMENU = preload("res://assets/gui/main_menu/main_menu.tscn")
const INGAMEMENU = preload("res://assets/gui/in_game_menu/in_game_menu.tscn")
const HUD = preload("res://assets/gui/hud/hud.tscn")
var menu:Control
var hud:CanvasLayer

func _ready() -> void:
	menu = MAINMENU.instantiate()
	Messager.connect("load_level", on_load_level)
	Messager.connect("resume", on_resume_game)
	Messager.connect("back_to_main_menu", on_back_to_main_menu)
	add_child(menu)


func on_load_level():
	menu.queue_free()
	hud = HUD.instantiate()
	add_child(hud)
	
	
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
			hud.visible = false
			add_child(menu)
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif menu.ui_state == menu.MENUSTATES.MENU and menu.get_scene_file_path() == "res://assets/gui/in_game_menu/in_game_menu.tscn":
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			menu.queue_free()
			hud.visible = true
			get_tree().paused = false
