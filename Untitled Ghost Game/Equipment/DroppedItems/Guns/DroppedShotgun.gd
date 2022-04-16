extends "res://Equipment/DroppedItems/DroppedItemTemplate.gd"

func _ready():
	logo = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	item = load("res://Equipment/Guns/Shotgun.tscn")
	object_name = "Shotgun"
	$Sprite.texture = logo
