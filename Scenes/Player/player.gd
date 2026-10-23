extends CharacterBody2D
class_name Player


const SPEED = 100.0

@export var bullet_scene: PackedScene
@export var hp: int = 3
var can_shoot: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_marker: Marker2D = $BulletMarker


func _physics_process(_delta: float) -> void:
	if hp <= 0:
		return
	
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * SPEED
	move_and_slide()
	
	if direction.length() > 0:
		can_shoot = false
		if animated_sprite_2d.animation != "run":
			animated_sprite_2d.play("run")
		# 翻转
		animated_sprite_2d.flip_h = direction.x < 0
	else:
		can_shoot = true
		if animated_sprite_2d.animation != "idle":
			animated_sprite_2d.play("idle")
		animated_sprite_2d.flip_h = false


func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		_die()


func _die() -> void:
	animated_sprite_2d.play("die")


## 子弹射出计时器
func _on_bullet_timer_timeout() -> void:
	if not can_shoot:
		return
	
	var bullet_node:Node2D = bullet_scene.instantiate()
	if bullet_node == null:
		push_error("bullet scene为空")
	get_tree().current_scene.add_child(bullet_node)
	bullet_node.global_position = bullet_marker.global_position
