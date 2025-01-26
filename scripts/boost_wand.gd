extends Area2D

@onready var game_manager: Node = %GameManager
@onready var boost_wand: Area2D = $"."
@onready var boost_text: Label = $"../BoostText"

func _on_body_entered(body: Node2D) -> void:
	game_manager.activate_boost_wand()
	boost_text.show_boost_text()
	print("boost activated")
