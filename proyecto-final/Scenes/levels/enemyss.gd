extends CharacterBody2D
@onready var terget: CharacterBody2D = $"../CharacterBody2D"
var speed=180

func _physics_process(delta: float) -> void:
	var direction=(terget.position-position).normalized()
	velocity=direction * speed

	move_and_slide()
