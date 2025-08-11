# Enemy.gd
# Este script va en un nodo Enemy de tipo CharacterBody2D.
# Añade como hijo un Area2D (por ejemplo llamado “Hitbox”) con su CollisionShape2D
# y conecta su señal body_entered a _on_area_body_entered.

extends CharacterBody2D

@export var speed: float = 200.0   # Velocidad de persecución
@export_group("Node Paths")
@export var player_path: NodePath  # Ruta al nodo del jugador (Player)

@onready var player: NodePath = get_node_or_null $"."
@onready var hitbox: Area2D = $HitboxArea

func _ready():
	# Nos aseguramos de escuchar la señal de colisión con el jugador
	hitbox.connect("body_entered", callable(self, "_on_area_body_entered"))

func _physics_process(delta: float) -> void:
	if not player:
		return  # Si no hay jugador, no hacemos nada

	# Calcula dirección al jugador y mueve al enemigo
	var dir: Vector2 = (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()

func _on_area_body_entered(body: Node) -> void:
	# Si el cuerpo que entró es el jugador, reiniciamos el nivel
	if body == player:
		get_tree().reload_current_scene()
