extends Control

export var item_slot = 0

func check(current_slot):
	if current_slot == item_slot:
		select()
	else:
		deselect()

func select():
	$ItemFrame.modulate = "#ffffff"

func deselect():
	$ItemFrame.modulate = "#aca403"


func equip_logo(current_slot, logo):
	if current_slot == item_slot:
		$ItemFrame/Item.texture = logo

func remove_logo(current_slot):
	if current_slot == item_slot:
		$ItemFrame/Item.texture = null
