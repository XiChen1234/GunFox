@tool
extends Node2D
class_name EnemySpawner

## 敌人场景
@export var enemy_scene: PackedScene
@export var spawn_area: Rect2 = Rect2(0, 0, 100, 100):
	set(value):
		spawn_area = value
		if Engine.is_editor_hint():
			queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(spawn_area, Color(0.8, 0.3, 0.2, 0.7), true)


func _ready() -> void:
	_spawn_enemy()


func _get_random_spawn_position() -> Vector2:
	return Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y)
	)


## 生成怪物
func _spawn_enemy() -> void:
	if enemy_scene == null:
		push_error("EnemySpawner enemy_scene 未设置")
		return

	var enemy_node: Enemy = enemy_scene.instantiate()
	add_child.call_deferred(enemy_node)
	enemy_node.global_position = global_position + _get_random_spawn_position()


func _on_enemy_spawn_timer_timeout() -> void:
	_spawn_enemy()
