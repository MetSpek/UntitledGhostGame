extends StaticBody2D

var logo = load("res://Assets/Sprites/Equipment/Logo/SaltLogo.png")
var item = load("res://Equipment/SaltCan.tscn")

func pickup(place):
	var item_instance = item.instance()
	GlobalStats.inventory[place] = item_instance
	get_tree().get_root().get_child(2).get_node("PlayerCharacter").get_node("Inventory").add_child(item_instance)
	get_tree().call_group("UI", "equip_logo", place + 1, logo)
