extends CharacterBody2D

# --- Variables del jugador ---
var vida : int = 100
var puntaje : int = 0
var velocidad : int = 300
var gravedad : int = 1000
var fuerza_salto : int = -400

@onready var label_puntaje : Label = $"../UI_Puntaje"

func _ready():
	actualizar_label()
	add_to_group("jugador")  # Añade al grupo al cargar la escena

func _physics_process(delta):
	# Movimiento y gravedad (como antes)
	if not is_on_floor():
		velocity.y += gravedad * delta
	
	var direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * velocidad
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = fuerza_salto
	
	move_and_slide()
	


# --- Sistema de puntos y Label ---
func sumar_puntos(cantidad : int):
	puntaje += cantidad
	actualizar_label()

func actualizar_label():
	label_puntaje.text = "Vida: %d\nPuntos: %d" % [vida, puntaje]

func save():
	var datos = 
	{
		"jugador":{
			"puntaje": puntaje,
			"vida": vida,
			"posición": {
				"x": "%.8f" % global_posittion.x,
				"y": "%.8f" % global_posittion.y

			}
		}
	}
	
	#código para guardar JSON
	var json_texto = JSON.stringify()
	
	pass
