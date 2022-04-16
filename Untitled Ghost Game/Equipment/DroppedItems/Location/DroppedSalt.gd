extends "res://Equipment/DroppedItems/DroppedItemTemplate.gd"

func _ready():
	logo = load("res://Assets/Sprites/Equipment/Logo/SaltLogo.png")
	item = load("res://Equipment/SaltCan.tscn")
	object_name = "Salt Can"
	$Sprite.texture = logo
