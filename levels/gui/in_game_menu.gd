extends Control
enum MENUSTATES {MENU, OPTION, LOAD}
var ui_state = MENUSTATES.MENU

func _on_settings_button_up() -> void:
	ui_state = MENUSTATES.OPTION
	$MenuContent.visible = false
	$OptionMenu.visible = true

func _on_load_button_up() -> void:
	ui_state = MENUSTATES.LOAD
	$MenuContent.visible = false
	$LoadMenu.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match ui_state:
			MENUSTATES.OPTION:
				ui_state = MENUSTATES.MENU
				$MenuContent.visible = true
				$OptionMenu.visible = false
				accept_event()
			MENUSTATES.LOAD:
				ui_state = MENUSTATES.MENU
				$MenuContent.visible = true
				$LoadMenu.visible = false
				accept_event()
				
			


func _on_exit_button_up() -> void:
	get_tree().quit()


func _on_resume_button_up() -> void:
	Messager.resume.emit()


func _on_main_menu_button_up() -> void:
	Messager.back_to_main_menu.emit()
