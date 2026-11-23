extends Area2D
class_name Enemy


@export var speed: float = 50
@export var damage: int = 1
@export var hp: int = 1

var is_dead: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	position.x -= speed * delta
	
	if position.x < -260:
		queue_free()


## 造成伤害
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
	speed = 0
	hp = 0
	animated_sprite_2d.play("die")


## 死亡动画播放完毕触发
func _on_animated_sprite_2d_animation_finished() -> void:
	if is_dead and animated_sprite_2d.animation == "die":
		queue_free()


## 史莱姆碰到玩家触发
func _on_body_entered(body: Node2D) -> void:
	if is_dead: 
		return
	if body is Player:
		body.take_damage(damage)
		_die()
