extends Node2D

@export var speed: float = 200
@export var damage: int = 1


func _physics_process(delta: float) -> void:
	position.x += speed * delta
	if position.x > 250:
		queue_free()


## 敌人的碰撞箱进入子弹
func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.take_damage(damage)
		queue_free()
