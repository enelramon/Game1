extends Node2D

const MAX_ENEMIES = 15

const SPAWN_POSITIONS = [
	Vector2(50, 50),
	Vector2(550, 350)
]

@export var enemy_scene: PackedScene

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.died.connect(_on_enemy_died)

func _on_enemy_died() -> void:
	call_deferred("_spawn_enemies")

func _spawn_enemies() -> void:
	var current_count = get_tree().get_nodes_in_group("Enemies").size()
	var to_spawn = min(2, MAX_ENEMIES - current_count)
	for i in range(to_spawn):
		_spawn_enemy(SPAWN_POSITIONS[i % SPAWN_POSITIONS.size()])

func _spawn_enemy(spawn_position: Vector2) -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_position
	add_child(enemy)
	enemy.died.connect(_on_enemy_died)
