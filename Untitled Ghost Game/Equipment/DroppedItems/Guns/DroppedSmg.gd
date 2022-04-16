extends "res://Equipment/DroppedItems/DroppedItemTemplate.gd"

func _ready():
	logo = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	item = load("res://Equipment/Guns/Smg.tscn")
	object_name = "Submachine Gun"
	$Sprite.texture = logo
