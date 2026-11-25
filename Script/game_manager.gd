extends Node

signal score_changed(new_score: int)


var current_score: int = 0


func add_score(score: int = 1) -> void:
	current_score += score
	score_changed.emit(current_score)
