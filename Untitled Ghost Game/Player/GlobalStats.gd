extends Node

#Inventory
var inventory

#Bullets
var type_bullet
var bullet_amount
var remaining_pistol_bullets
var remaining_smg_bullets
var remaining_shotgun_bullets
var remaining_assault_bullets

#Equipment
var salt_usages


#ITEMS
var pistol
var smg
var shotgun
var assault
var salt

var item_list

func _ready():
	#Inventory
	inventory = [null, null, null]

#Bullets
	type_bullet = "standard"
	bullet_amount = 240
	remaining_pistol_bullets = 7
	remaining_smg_bullets = 25
	remaining_shotgun_bullets = 5
	remaining_assault_bullets = 30

#Equipment
	salt_usages


#ITEMS
	pistol = {
	"name" : "Pistol",
	"source" : "res://Equipment/Guns/Pistol.tscn"}
	smg = {
	"name" : "Submachine Gun",
	"source" : "res://Equipment/Guns/Smg.tscn"}
	shotgun = {
	"name" : "Shotgun",
	"source" : "res://Equipment/Guns/Shotgun.tscn"}
	assault = {
	"name" : "Assault Rifle",
	"source" : "res://Equipment/Guns/AssaultRifle.tscn"}
	salt = {
	"name": "Salt Can",
	"source": "res://Equipment/Location/SaltCan.tscn"}

	item_list = [pistol, smg, shotgun, assault, salt]
	
