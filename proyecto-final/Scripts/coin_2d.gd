extends Area2D

signal puerta_llave


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		emit_signal("puerta_llave")
		body.agregar_moneda()

		queue_free()
