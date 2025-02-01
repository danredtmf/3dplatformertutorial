class_name Settings extends Control

@export var main_menu: MainMenu
@export var pause_menu: PauseGameUI

@onready var mouse_s_name: Label = %MouseSName
@onready var mouse_s: HSlider = %MouseS
@onready var mouse_s_value: Label = %MouseSValue

func _ready() -> void:
	update_mouse_s_value(Global.sensitivity)
	mouse_s.value = Global.sensitivity

func update_mouse_s_value(value: float) -> void:
	mouse_s_value.text = "%s" % [value]

# Нужно привязать сигнал "value_changed" у слайдера "MouseS"
func _on_mouse_s_value_changed(value: float) -> void:
	update_mouse_s_value(value)
	Global.sensitivity = value

# Нужно привязать сигнал "pressed" у кнопки "Back"
func _on_back_pressed() -> void:
	if main_menu:
		main_menu.set_state(main_menu.States.Main)
	elif pause_menu:
		pause_menu.set_state(pause_menu.States.Pause)
	SaveLoad.save_data()

# Нужно привязать сигнал "pressed" у кнопки "ResetSettings"
func _on_reset_settings_pressed() -> void:
	Global.sensitivity = 1.0
	mouse_s.value = Global.sensitivity
	update_mouse_s_value(mouse_s.value)
	SaveLoad.save_data()
