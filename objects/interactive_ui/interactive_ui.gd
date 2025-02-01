class_name InteractiveUI extends Control

var _item: InteractiveItem

@onready var _panel: PanelContainer = %Panel
@onready var _info: Label = %Info
@onready var _desc: Label = %Desc

func _ready() -> void:
	_panel.hide()
	_config_signals()

func _config_signals() -> void:
	EventBus.interactive_ui_shown.connect(_on_interactive_ui_shown.bind())
	EventBus.interactive_ui_hide.connect(_on_interactive_ui_hide.bind())

func _on_interactive_ui_shown(new: InteractiveItem) -> void:
	if new == null:
		_panel.show()
	elif not _item == new:
		_item = new
		_info.text = _item.ui_name
		_desc.text = _item.ui_desc
	
	_panel.show()

func _on_interactive_ui_hide() -> void:
	_panel.hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if _panel.visible and is_instance_valid(_item):
			EventBus.interactive_item_interacted.emit(_item)
