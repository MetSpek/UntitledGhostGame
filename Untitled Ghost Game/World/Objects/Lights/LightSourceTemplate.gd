extends Light2D

export var light_group = "Unset"

func toggle_light(group):
	if group == light_group:
		visible = !visible
