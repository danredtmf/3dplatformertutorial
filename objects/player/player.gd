class_name Player extends CharacterBody3D

const WALK_SPEED := 5.0
const RUN_SPEED := 10.0
const JUMP_VELOCITY := 4.5
const JUMP_MOD_DEFAULT := 1.0

var is_jump_modified := false
var jump_mod := JUMP_MOD_DEFAULT
var gravity_mod := 1.2
var speed := WALK_SPEED
var sensitivity := 0.01
var acceleration := 1.0
var head_angle := 75.0

@onready var head: Node3D = %Head
@onready var camera: Camera3D = %Camera3D

func _ready() -> void:
	# Скрыть мышь во время запуска игры
	# Точнее, как только данный объект появится в игре
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Гравитация
	if not is_on_floor():
		velocity += get_gravity() * gravity_mod * delta
	
	# Прыжок
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		if is_jump_modified:
			velocity.y = JUMP_VELOCITY * jump_mod
		else:
			velocity.y = JUMP_VELOCITY
	
	# Бег или ходьба.
	# Без проверки `is_on_floor()` игрок может увеличивать скорость
	# в воздухе
	if Input.is_action_pressed("run"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED
	
	# Движение персонажа (в этой строчке ничего не изменено)
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	# убран `head` в `transform.basis`
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
		velocity.z = move_toward(velocity.z, 0, acceleration)
	
	# Движение исходя из изменений `velocity`
	move_and_slide()

# Перехват ранее неперехваченных вводов
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# убран `head` в начале строки
		rotate_y(-event.relative.x * sensitivity * Global.sensitivity)
		# замена `camera` на `head`
		head.rotate_x(-event.relative.y * sensitivity * Global.sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-head_angle), deg_to_rad(head_angle))
