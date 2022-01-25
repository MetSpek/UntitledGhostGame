extends Node

func apply_damage(current_hp, damage):
	current_hp -= damage
	return current_hp
