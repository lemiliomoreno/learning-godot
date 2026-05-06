extends CharacterBody2D


signal personaje_muerto

@export var animacion: AnimatedSprite2D
@export var area_2d: Area2D
@export var material_personaje_rojo: ShaderMaterial

var _velocidad: float = 100.0
var _velocidad_salto: float = 300.0
var _muerto: bool = false


func _ready():
	add_to_group("personajes")
	area_2d.body_entered.connect(_on_area_2d_body_entered)


func _physics_process(delta):
	if _muerto:
		return

	# gravedad
	velocity += get_gravity() * delta

	# salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y += -_velocidad_salto

	# movimiento horizontal
	if Input.is_action_pressed("derecha"):
		velocity.x = _velocidad
		animacion.play("correr")
		animacion.flip_h = true

	elif Input.is_action_pressed("izquierda"):
		velocity.x = -_velocidad
		animacion.play("correr")
		animacion.flip_h = false

	else:
		velocity.x = 0
		animacion.play("idle")

	move_and_slide()

	if !is_on_floor():
		animacion.play("saltar")


func _on_area_2d_body_entered(_body: Node2D) -> void:
	animacion.material = material_personaje_rojo
	# se puede hacer también con el modulate de la animación
	# animacion.modulate = Color.RED
	_muerto = true
	animacion.stop()

	await get_tree().create_timer(0.5).timeout

	personaje_muerto.emit()

	ControladorGlobal.sumar_muerte()
