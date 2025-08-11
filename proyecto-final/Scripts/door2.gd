extends Node2D

var llave = 0

@onready var ui_label = $"../Puerta/Label"


func _ready() -> void:
	upgrade_ui()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "personaje" and llave == 1:
			queue_free()
			
	elif body.get_name() == "personaje" and llave == 0:
		ui_label.text = "Necesitas la llave para abrir la puerta"
		await get_tree().create_timer(0.6).timeout
		upgrade_ui()
		

func _on_llave_puerta_llave() -> void:
	llave = 1  
	upgrade_ui()
	
	
func upgrade_ui() -> void:
	if llave == 1:
		ui_label.text = "Llaves: 1"
		
		await get_tree().create_timer(0.5).timeout
		
	else:
		ui_label.text = "Llaves: 0"
