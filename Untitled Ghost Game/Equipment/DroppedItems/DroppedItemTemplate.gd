extends StaticBody2D

var logo
var item
var object_name



func pickup(place):
	var item_instance = item.instance()
	GlobalStats.inventory[place] = item_instance
	get_tree().get_root().get_node("LevelTemplate").get_node("PlayerCharacter").get_node("Inventory").add_child(item_instance)
	get_tree().call_group("UI", "equip_logo", place + 1, logo)
	if item_instance.has_method("show_bullets"):
		item_instance.show_bullets()
		
