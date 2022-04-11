extends Control



func _ready():
	set_correct_values()

func set_correct_values():
	#Player
	$PlayerMoney.text = str(Account.money) + "$"
	
	#Salt Can
	if Account.salt_level != ShopUpgrades.max_salt_level:
		$EquipmentUpgradesScrollContainer/ContainerContainer/SaltUpgrade/UpgradeTemplate/UpgradeLevel.text = "Lvl " + str(Account.salt_level + 1)
		$EquipmentUpgradesScrollContainer/ContainerContainer/SaltUpgrade/UpgradeTemplate/SaltButton.text = str(ShopUpgrades.salt_upgrades[Account.salt_level].price) + "$"
		$EquipmentUpgradesScrollContainer/ContainerContainer/SaltUpgrade/UpgradeText.text = ShopUpgrades.salt_upgrades[Account.salt_level].use
	else:
		$EquipmentUpgradesScrollContainer/ContainerContainer/SaltUpgrade.queue_free()
	

func remove_money(amount):
	Account.money = Account.money - amount
	$PlayerMoney.text = str(Account.money) + "$"

func _on_ShopButton_pressed():
	get_tree().change_scene("res://World/Menus/MainMenu.tscn")


func _on_SaltButton_pressed():
	if Account.money >= ShopUpgrades.salt_upgrades[Account.salt_level].price:
		remove_money(ShopUpgrades.salt_upgrades[Account.salt_level].price)
		GlobalStats.salt_usages += ShopUpgrades.salt_upgrades[Account.salt_level - 1].salt_usages
		Account.salt_level += 1
		if Account.salt_level == ShopUpgrades.max_salt_level:
			$EquipmentUpgradesScrollContainer/ContainerContainer/SaltUpgrade.queue_free()
		else:
			set_correct_values()
