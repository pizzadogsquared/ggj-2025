extends Node
@onready var camera: Camera2D = $"../Camera2D"
@onready var player: CharacterBody2D = $"../Player"


var has_wand1: bool
var has_wand2: bool
var has_wand3: bool


func game_over():
	player.is_killed = true
