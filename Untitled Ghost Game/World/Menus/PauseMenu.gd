extends CanvasLayer

func pause_game():
	get_tree().paused = true
	$PauseMenuPopup.popup()


func _on_ResumeButton_pressed():
	get_tree().paused = false
	$PauseMenuPopup.hide()


func _on_OptionsButton_pressed():
	pass # Replace with function body.


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://World/Menus/MainMenu.tscn")


func _on_ExitGameButton_pressed():
	get_tree().quit()


func _on_PauseMenuPopup_popup_hide():
	get_tree().paused = false
