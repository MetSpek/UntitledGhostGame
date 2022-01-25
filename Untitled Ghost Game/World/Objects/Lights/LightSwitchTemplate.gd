extends StaticBody2D

export var light_group = "Unset"


func use():
	get_tree().call_group("LightSource", "toggle_light", light_group)
