extends Area2D

signal puerta_llave


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		queue_free()
