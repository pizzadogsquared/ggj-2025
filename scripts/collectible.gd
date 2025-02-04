extends Area2D

@onready var game_manager: Node = %GameManager
@onready var collectible: Area2D = $"."

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	collectible.queue_free()
