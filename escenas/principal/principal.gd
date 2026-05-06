extends Node2D


@export var niveles: Array[PackedScene]

var _nivel_actual: int = 1
var _nivel_instanciado: Node


func _ready() -> void:
	_crear_nivel(_nivel_actual)


func _crear_nivel(nivel: int):
	_nivel_instanciado = niveles[nivel - 1].instantiate()
	add_child(_nivel_instanciado)	

	var hijos := _nivel_instanciado.get_children()

	for i in hijos.size():
		if hijos[i].is_in_group("personajes"):
			hijos[i].personaje_muerto.connect(_reiniciar_nivel)
			break


func _eliminar_nivel():
	_nivel_instanciado.queue_free()


func _reiniciar_nivel():
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)


func siguiente_nivel():
	_nivel_actual += 1
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)
