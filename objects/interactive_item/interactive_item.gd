@tool
class_name InteractiveItem extends Area3D

@export var id: String
@export var ui_name: String
@export var ui_desc: String
@export var disabled: bool

@export var size := Vector3.ONE

@onready var _mesh: MeshInstance3D = $Mesh
@onready var _shape: CollisionShape3D = $Shape

func _ready() -> void:
	if not Engine.is_editor_hint():
		set_process(false)
	if not OS.is_debug_build():
		_mesh.hide()
	
	_mesh.mesh = _mesh.mesh.duplicate()
	_shape.shape = _shape.shape.duplicate()
	_set_size()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_set_size()

func _set_size() -> void:
	_mesh.mesh.size = size
	_shape.shape.size = size
