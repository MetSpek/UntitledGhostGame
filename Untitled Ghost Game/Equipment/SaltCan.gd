extends Node2D
var groundsalt = load("res://World/Objects/Props/GroundSalt.tscn")
var item = load("res://Equipment/DroppedItems/Location/DroppedSalt.tscn")


func use(position):
	if GlobalStats.salt_usages > 0:
		var salt_instance = groundsalt.instance()
		salt_instance.position.x = position.x
		salt_instance.position.y = position.y + 15
		get_tree().get_root().add_child(salt_instance)
		GlobalStats.salt_usages -= 1
	else:
		print("No Salt usages left")

func drop(position, place):
	var item_instance = item.instance()
	item_instance.global_position = position
	get_tree().get_root().get_node("LevelTemplate").get_node("Props").add_child(item_instance)
	get_tree().call_group("UI", "remove_logo", place + 1)
	queue_free()
