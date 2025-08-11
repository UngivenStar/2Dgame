extends Area2D
 
#variables
enum type_plat {FIJA, OSCILATORIAH, OSCILATORIAV, FRAGIL, REBOTE, REINICIO}
@export var type: type_plat = type_plat.FIJA;
@export var rebote := 2.0 

func _ready():
	act_plat()
	monitorable = true
	monitoring = true
	
#cambiar de plataforma segun su tipo
func act_plat():
	match type:
		type_plat.FIJA:
			$Sprite2D.modulate
		type_plat.OSCILATORIAH:
			$Sprite2D.modulate
			oscilarh()
		type_plat.FRAGIL:
			$Sprite2D.modulate
			
		type_plat.REBOTE:
			$Sprite2D.modulate
			
		type_plat.REINICIO:
			$Sprite2D.modulate = Color.RED
			
		type_plat.OSCILATORIAV:
			$Sprite2D.modulate
			oscilarv()

#señal
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		match type:
			type_plat.FRAGIL:
					await get_tree().create_timer(0.25).timeout
					queue_free()
			type_plat.REBOTE:
				if body.has_method("puede_rebotar"):
					body.puede_rebotar(rebote)
				else:
					body.velocity.y = body.JUMP_VELOCITY * rebote
			type_plat.REINICIO:
					get_tree().reload_current_scene()



#funcion para oscilar horizontalmente
func oscilarh():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x+100, 2)
	tween.tween_property(self, "position:x", position.x-100, 2)
	tween.set_loops()

#funcion para oscilar verticalmente

func oscilarv():
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y+100, 2)
	tween.tween_property(self, "position:y", position.y-100, 2)
	tween.set_loops()
