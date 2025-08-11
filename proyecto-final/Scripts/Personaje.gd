extends CharacterBody2D

const SPEED = 450.0
const JUMP_VELOCITY = -450.0
const MAX_JUMPS = 2
var has_key: bool = false
@onready var animated_sprite = $AnimatedSprite
@export var next_level_scene: String = ""
var is_facing_right = true
var jumps = 0
var monedas := 0
@onready var label_monedas: Label = $Camera2D/ui/MonedaNum
@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var detector = $Detector

func _ready():
	add_to_group("personaje")
	


func _physics_process(delta: float) -> void:
	update_animations()
	flip()
	# Agregar gravedad si no estamos en el suelo
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reiniciar los saltos al tocar el suelo
		jumps = 0

	# Manejo de salto (hasta dos saltos)
	if Input.is_action_just_pressed("ui_accept") and jumps < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps += 1

	# Movimiento horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

	if Input.is_action_pressed("guardar"):
		guardar_datos()
	if Input.is_action_pressed("cargar"):
		cargar_datos()


func flip():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		scale.x *= -1
		is_facing_right = not is_facing_right
		


#animaciones
func update_animations():
	if not is_on_floor(): 
		if velocity.y < 0:
				animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		return

	if velocity.x: 
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")


func agregar_moneda():
	monedas += 1
	label_monedas.text = str(monedas)
	
func total_mon():
	$Camera2D/ui/Total_monedas.text = "Monedas obtenidas:" % monedas
	


func guardar_datos():
	
	var datos = {
		"personaje": {
			"monedas": monedas,
			"posicion": {
				"x": "%.8f" % global_position.x,
				"y": "%.8f" % global_position.y
			}			
		}
	}
	#Código para guardar JSON
	var json_texto = JSON.stringify(datos, "\t")
	var archivo = FileAccess.open("res://extra/datos/juego_guardado.json",FileAccess.WRITE)
	archivo.store_string(json_texto)
	archivo.close()
	print("Todo salió bien, archivo guardado")
	
	
func cargar_datos():
	
	if not FileAccess.file_exists("res://extra/datos/juego_guardado.json"):
		print("No hay archivo")
		return
		
	var archivo = FileAccess.open("res://extra/datos/juego_guardado.json",FileAccess.READ)
	var json_caracter = archivo.get_as_text()
	archivo.close()
	
	var json = JSON.new()
	var error = json.parse(json_caracter)
	if error != OK:
		print("No se parseó", json.get_error_message())
	
	var datos = json.get_data()
	
	global_position = Vector2(		
		float(datos["personaje"]["posicion"]["x"]),
		float(datos["personaje"]["posicion"]["y"])
	)
	
	monedas = datos["personaje"]["monedas"]
