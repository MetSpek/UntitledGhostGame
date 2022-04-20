extends StaticBody2D

var object_name = "Storage"

func use():
	get_tree().call_group("ItemStorage", "open_storage")
