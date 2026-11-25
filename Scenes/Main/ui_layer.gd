extends CanvasLayer
class_name UILayer

@export var heart_texture: Texture2D
@export var heart_empty_texture: Texture2D

@onready var hp_container: HBoxContainer = $HPContainer
@onready var score_label: Label = $ScoreLabel

var player: Player


func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)


## 分数更新函数
func _on_score_changed(score: int) -> void:
	score_label.text = "Score: %d" % score


func set_player(target: Player) -> void:
	player = target
	player.hp_changed.connect(_on_player_hp_changed)
	_on_player_hp_changed(player.hp, player.max_hp)


## 玩家血量更新函数
func _on_player_hp_changed(hp: int, max_hp: int) -> void:
	var hearts: Array = hp_container.get_children()
	for index in range(max_hp):
		var heart: TextureRect = hearts[index]
		if index < hp:
			heart.texture = heart_texture
		else:
			heart.texture = heart_empty_texture
