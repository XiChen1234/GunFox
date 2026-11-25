extends CanvasLayer
class_name UILayer


@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	GameManager.enemy_killed.connect(score_update)
	score_update(0)
	


## 分数更新函数
func score_update(score: int) -> void:
	GameManager.score_add(score)
	score_label.text = "Score: " + str(GameManager.current_score)
