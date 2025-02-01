class_name MainMenu extends Control

enum States { Main, Levels, Settings, About, Quit }
var current_state: States = States.Main

@onready var main_state: VBoxContainer = %MainState
# Их заменим позже
@onready var levels_state: LevelsState = %LevelsState
@onready var settings_state: Settings = %SettingsState
@onready var about_state: AboutState = %AboutState

@onready var back_dark: ColorRect = %BackDark
@onready var front_dark: ColorRect = %FrontDark
@onready var quit_dialog: ConfirmationDialog = %QuitDialog

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	set_state(States.Main)

func check_state() -> void:
	match current_state:
		States.Main:
			back_dark.hide()
			main_state.show() # Показываем главный экран меню
			levels_state.hide()
			settings_state.hide()
			about_state.hide()
			front_dark.hide()
			quit_dialog.hide()
		States.Levels:
			back_dark.show() # Затемняем пространство за экранами
			main_state.hide()
			levels_state.show() # Показываем экран выбора уровня
			settings_state.hide()
			about_state.hide()
			front_dark.hide()
			quit_dialog.hide()
		States.Settings:
			back_dark.show() # Затемняем пространство за экранами
			main_state.hide()
			levels_state.hide()
			settings_state.show() # Показываем экран настроек
			about_state.hide()
			front_dark.hide()
			quit_dialog.hide()
		States.About:
			back_dark.show() # Затемняем пространство за экранами
			main_state.hide()
			levels_state.hide()
			settings_state.hide()
			about_state.show() # Показываем экран об игре
			front_dark.hide()
			quit_dialog.hide()
		States.Quit:
			back_dark.hide()
			main_state.show() # Показываем главный экран меню
			levels_state.hide()
			settings_state.hide()
			about_state.hide()
			front_dark.show() # Затемняем пространство после экранов
			quit_dialog.show() # Показывам диалог выхода из игры

func set_state(value: States) -> void:
	current_state = value
	check_state()

# Нужно привязать сигнал "pressed" у кнопки "SelectLevel"
func _on_select_level_pressed() -> void:
	set_state(States.Levels)

# Нужно привязать сигнал "pressed" у кнопки "Settings"
func _on_settings_pressed() -> void:
	set_state(States.Settings)

# Нужно привязать сигнал "pressed" у кнопки "About"
func _on_about_pressed() -> void:
	set_state(States.About)

# Нужно привязать сигнал "pressed" у кнопки "Quit"
func _on_quit_pressed() -> void:
	set_state(States.Quit)

# Нужно привязать сигнал "confirmed" у объекта "QuitDialog"
func _on_quit_dialog_confirmed() -> void:
	get_tree().quit()

# Нужно привязать сигнал "canceled" у объекта "QuitDialog"
func _on_quit_dialog_canceled() -> void:
	set_state(States.Main)
