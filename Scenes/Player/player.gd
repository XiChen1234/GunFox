extends CharacterBody2D
class_name Player


const SPEED = 100.0

@export var bullet_scene: PackedScene
@export var hp: int = 3
@export var fire_interval: float = 1.0

var is_dead: bool = false
var can_shoot: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_marker: Marker2D = $BulletMarker
@onready var bullet_timer: Timer = $BulletTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	bullet_timer.wait_time = fire_interval


func _physics_process(_delta: float) -> void:
	if is_dead:
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
	if is_dead:
		return
	hp -= amount
	if hp <= 0:
		_die()


func _die() -> void:
	if is_dead:
		return
	is_dead = true
	can_shoot = false
	velocity = Vector2.ZERO
	bullet_timer.stop()
	collision_shape_2d.set_deferred("disabled", true)
	animated_sprite_2d.play("die")


## 子弹射出计时器
func _on_bullet_timer_timeout() -> void:
	if not can_shoot:
		return
		
	if bullet_scene == null:
		push_error("Player bullet_scene 未设置")
		return
	
	var bullet_node: Node2D = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet_node)
	bullet_node.global_position = bullet_marker.global_position
