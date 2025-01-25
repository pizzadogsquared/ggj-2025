extends Node

@onready var player: CharacterBody2D = $"../Player"


var has_boostwand: bool
var has_wand2: bool
var has_wand3: bool

var score = 0

func game_over():
	player.is_killed = true

func add_point():
	score += 1
	
func activate_boost_wand():
	player.has_boost_wand = true
