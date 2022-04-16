extends Node

func _on_StartButton_pressed():
	get_tree().change_scene("res://World/WorldTest.tscn")


func _on_OptionsButton_pressed():
	print("options")

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_ShopButton_pressed():
	get_tree().change_scene("res://World/Menus/Shop.tscn")

