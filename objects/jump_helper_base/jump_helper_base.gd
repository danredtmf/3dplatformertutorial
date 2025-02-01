# @tool даёт возможность выполнять операции непосредственно в редакторе
# ИСПОЛЬЗУЙТЕ ОСТОРОЖНО!
# Рекомендую добавить данную строку в конце работы над скриптом
@tool
class_name JumpHelperBase extends Area3D

# @export_range - ограниченный диапозон значений у переменной
@export_range(1.0, 100.0) var jump_mod := 1.0
@export var color: Color = Color.WHITE

@onready var mesh_front: MeshInstance3D = $MeshFront
@onready var mesh_back: MeshInstance3D = $MeshBack

var mesh_front_material: StandardMaterial3D
var mesh_back_material: StandardMaterial3D

func _ready() -> void:
	check_materials()
	get_meshes_color()

func _process(_delta: float) -> void:
	# Изменение цвета в редакторе
	if Engine.is_editor_hint():
		get_meshes_color()

# Если материалы не найдены
func check_materials() -> void:
	if mesh_front_material == null or mesh_back_material == null:
		mesh_front_material = mesh_front.get_surface_override_material(0).duplicate() as StandardMaterial3D
		mesh_back_material = mesh_back.get_surface_override_material(0).duplicate() as StandardMaterial3D
		mesh_front.set_surface_override_material(0, mesh_front_material)
		mesh_back.set_surface_override_material(0, mesh_back_material)
		return

func get_meshes_color() -> void:
	check_materials()
	
	# Убрать лишние операции
	if mesh_front_material.albedo_color.r == color.r and \
		mesh_front_material.albedo_color.g == color.g and \
		mesh_front_material.albedo_color.b == color.b and \
		mesh_back_material.albedo_color.r == color.r and \
		mesh_back_material.albedo_color.g == color.g and \
		mesh_back_material.albedo_color.b == color.b:
			return
	
	mesh_front_material.albedo_color.r = color.r
	mesh_front_material.albedo_color.g = color.g
	mesh_front_material.albedo_color.b = color.b
	
	mesh_back_material.albedo_color.r = color.r
	mesh_back_material.albedo_color.g = color.g
	mesh_back_material.albedo_color.b = color.b

# Нужно привязать сигнал "_on_body_entered" у обладателя данного скрипта
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.jump_mod = jump_mod
		body.is_jump_modified = true

# Нужно привязать сигнал "_on_body_exited" у обладателя данного скрипта
func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.is_jump_modified = false
