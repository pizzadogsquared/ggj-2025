extends Area2D

@onready var game_manager: Node = %GameManager
@onready var boost_wand: Area2D = $"."

func _on_body_entered(body: Node2D) -> void:
	game_manager.activate_boost_wand()
	
