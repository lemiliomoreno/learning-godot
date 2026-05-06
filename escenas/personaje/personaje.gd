extends CharacterBody2D


var platanos: int = 3
var dinero: float = -2.3
var saludo: String = "hola"
var encendida: bool = true


func _ready():
	mi_funcion()

func mi_funcion():
	if encendida:
		print("prendida")
	else:
		print("apagado")
