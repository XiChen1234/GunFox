extends Node

@warning_ignore("unused_signal")
signal enemy_killed(score: int)


var current_score: int = 0


func score_add(score: int = 1) -> void:
	current_score += score
