extends Area2D
 
enum type_plat {FIJA, RESET}
@export var type: type_plat = type_plat.FIJA;
@export var rebote := 2.0 


func _ready():
	act_plat()
	monitorable = true
	monitoring = true
	

func act_plat():
	match type:
		type_plat.FIJA:
			$Sprite2D.modulate

		type_plat.RESET:
			$Sprite2D.modulate = Color.RED


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		match type:
			type_plat.RESET:
					get_tree().reload_current_scene()
