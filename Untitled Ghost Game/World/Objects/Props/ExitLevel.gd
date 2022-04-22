extends StaticBody2D

var object_name = "Exit level"

func use():
	get_tree().change_scene("res://World/Menus/EndGame.tscn")
