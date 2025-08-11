extends Node2D

var llave = false

@onready var ui_label = $"../door/Label"

func _ready() -> void:
	upgrade_ui()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje") and llave == true:
			queue_free()
			
	elif body.is_in_group("personaje") and llave == false:
		ui_label.text = "Necesitas la llave para abrir la puerta"
		await get_tree().create_timer(0.6).timeout
		upgrade_ui()

func _on_llave_puerta_llave() -> void:
	llave = true
	upgrade_ui()


func upgrade_ui() -> void:
	if llave == true:
		ui_label.text = "Llaves: 1"
		
		await get_tree().create_timer(0.5).timeout
		
	else:
		ui_label.text = "Llaves: 0"
