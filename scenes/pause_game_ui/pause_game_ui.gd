class_name PauseGameUI extends Control

const MAIN_MENU_SCENE_PATH := "res://scenes/main_menu/main_menu.tscn"

enum States { Game, Pause, Restart, Settings, InMainMenu }
var current_state := States.Game

@onready var pause_ui: MarginContainer = %PauseUI
@onready var settings_state: Settings = %SettingsState

func _ready() -> void:
	hide()
	pause_ui.show()
	settings_state.hide()

func check_state() -> void:
	match current_state:
		# Игрок играет
		States.Game:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
			hide()
			pause_ui.show()
			settings_state.hide()
		# Игрок приостанавливает игру
		States.Pause:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			show()
			pause_ui.show()
			settings_state.hide()
		# Игрок перезапускает уровень
		States.Restart:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
			get_tree().reload_current_scene()
		# Игрок открывает настройки
		States.Settings:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			pause_ui.hide()
			settings_state.show()
		# Игрок выходит из игры в главное меню
		States.InMainMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = false
			get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)

func set_state(value: States) -> void:
	current_state = value
	check_state()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		match current_state:
			States.Game:
				set_state(States.Pause)
			States.Pause:
				set_state(States.Game)
			States.Settings:
				set_state(States.Pause)

# Нужно привязать сигнал "pressed" у кнопки "Continue"
func _on_continue_pressed() -> void:
	set_state(States.Game)

# Нужно привязать сигнал "pressed" у кнопки "Restart"
func _on_restart_pressed() -> void:
	set_state(States.Restart)

# Нужно привязать сигнал "pressed" у кнопки "Settings"
func _on_settings_pressed() -> void:
	set_state(States.Settings)

# Нужно привязать сигнал "pressed" у кнопки "InMainMenu"
func _on_in_main_menu_pressed() -> void:
	set_state(States.InMainMenu)
