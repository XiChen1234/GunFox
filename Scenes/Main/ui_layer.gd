extends CanvasLayer
class_name UILayer


@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)


## 分数更新函数
func _on_score_changed(score: int) -> void:
	score_label.text = "Score: %d" % score
