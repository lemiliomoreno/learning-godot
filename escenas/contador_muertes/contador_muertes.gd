extends Control


@export var label: Label


func _ready() -> void:
	ControladorGlobal.muertes_actualizado.connect(_actualizar_texto)


func _actualizar_texto():
	label.text = str(ControladorGlobal.muertes)
