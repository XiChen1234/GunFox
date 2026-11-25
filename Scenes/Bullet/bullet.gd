extends Node2D

@export var speed: float = 200
@export var damage: int = 1


func _physics_process(delta: float) -> void:
	position.x += speed * delta
	# 子弹销毁
	if position.x > 250:
		queue_free()


## 敌人的碰撞箱进入子弹
func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.heart(damage)
		queue_free()
