extends Node2D

export var stairs_group = "Unset"


func _on_Area2D_body_entered(body):
	get_tree().call_group("Stairs", "change_level", stairs_group, body)

