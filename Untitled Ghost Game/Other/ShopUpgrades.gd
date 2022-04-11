extends Control

var salt_upgrades
var max_salt_level;

var salt_upgrade_1 = {
	"price" : 50,
	"use" : "+1 usage to the salt can.",
	"salt_usages" : 1
}

var salt_upgrade_2 = {
	"price" : 100,
	"use" : "+1 usage to the salt can.",
	"salt_usages" : 1
}


func _ready():
	salt_upgrades = [salt_upgrade_1, salt_upgrade_2]
	max_salt_level = salt_upgrades.size()
