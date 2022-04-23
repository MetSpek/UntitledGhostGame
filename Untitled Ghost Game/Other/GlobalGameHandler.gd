extends Node

var difficulties = ["easy"]
var difficulties_in_number = [1]
var levels = ["res://World/LevelTemplate.tscn"]
var level_source = [load("res://World/LevelTemplate.tscn")]
var xp_needed_per_level = [500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000]

var all_bullet_types = ["standard", "silver", "salted", "holy"]

var game_difficulty


var accumulated_xp = 0
var accumulated_money = 0


func _unhandled_input(event):
	if event.is_action_pressed("Pause_Game"):
			pause_game()


func pause_game():
	get_tree().call_group("PauseMenu", "pause_game")
