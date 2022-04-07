extends Position2D

export var stairs_group = "Unset"

func change_level(get_stairs_group, body):
	if get_stairs_group == stairs_group:
		body.global_position = global_position
