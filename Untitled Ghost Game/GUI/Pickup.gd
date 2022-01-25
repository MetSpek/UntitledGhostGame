extends Control

onready var interaction_label = $InteractionLabel


func show_interaction(interaction):
	interaction_label.text = "Press [E] for " + str(interaction)
	interaction_label.show()

func hide_interaction():
	interaction_label.hide()
