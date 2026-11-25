extends Node2D

@onready var ui_layer: UILayer = $UILayer
@onready var player: Player = $Player

func _ready() -> void:
	ui_layer.set_player(player)
	
