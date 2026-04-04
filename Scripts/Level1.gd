extends Node2D

const MAX_ENEMIES = 15
const WAVE_SIZE = 2
const WAVE_INTERVAL = 5.0

const SPAWN_POSITIONS = [
	Vector2(50, 50),
	Vector2(550, 350)
]

@export var enemy_scene: PackedScene

var total_spawned: int = 0
var wave_timer: Timer

func _ready() -> void:
	wave_timer = Timer.new()
	wave_timer.wait_time = WAVE_INTERVAL
	wave_timer.autostart = true
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	add_child(wave_timer)

func _on_wave_timer_timeout() -> void:
	if total_spawned >= MAX_ENEMIES:
		wave_timer.stop()
		return
	var to_spawn = min(WAVE_SIZE, MAX_ENEMIES - total_spawned)
	for i in range(to_spawn):
		_spawn_enemy(SPAWN_POSITIONS[i % SPAWN_POSITIONS.size()])
	if total_spawned >= MAX_ENEMIES:
		wave_timer.stop()

func _spawn_enemy(spawn_position: Vector2) -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_position
	add_child(enemy)
	total_spawned += 1
