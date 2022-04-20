extends Control

func _ready():
	add_values_to_account()
	show_values()

func show_values():
	$VBoxContainer/Money/MoneyAmount.text = "$" + str(GlobalGameHandler.accumulated_money)
	$VBoxContainer/Xp/XpAmount.text = str(GlobalGameHandler.accumulated_xp)
	$VBoxContainer/ProgressBar.max_value = GlobalGameHandler.xp_needed_per_level[Account.level]
	$VBoxContainer/ProgressBar.value = Account.xp
	$VBoxContainer/AccountLevelLabel.text = "Level " + str(Account.level)

func add_values_to_account():
	Account.money += GlobalGameHandler.accumulated_money
	Account.xp += GlobalGameHandler.accumulated_xp
	check_level_up()

func check_level_up():
	if Account.xp >= GlobalGameHandler.xp_needed_per_level[Account.level]:
		level_up_player()

func level_up_player():
	Account.xp = Account.xp - GlobalGameHandler.xp_needed_per_level[Account.level]
	Account.level += 1
	Account.money += Account.level * 1000
	check_level_up()

func _on_ExitButton_pressed():
	GlobalGameHandler.accumulated_xp = 0
	GlobalGameHandler.accumulated_money = 0
	get_tree().change_scene("res://World/Menus/MainMenu.tscn")
