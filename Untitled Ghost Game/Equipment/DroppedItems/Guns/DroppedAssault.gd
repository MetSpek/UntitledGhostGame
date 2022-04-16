extends "res://Equipment/DroppedItems/DroppedItemTemplate.gd"

func _ready():
	logo = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	item = load("res://Equipment/Guns/AssaultRifle.tscn")
	object_name = "Assault Rifle"
	$Sprite.texture = logo
