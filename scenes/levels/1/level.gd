extends Node3D

@onready var player: Player = $Player
@onready var teleport_marker_3d: Marker3D = $TeleportMarker3D

func _ready() -> void:
	EventBus.interactive_item_interacted.connect(_on_interactive_item_interacted.bind())

func _on_interactive_item_interacted(item: InteractiveItem) -> void:
	match item.id:
		"door":
			player.global_position = teleport_marker_3d.global_position
