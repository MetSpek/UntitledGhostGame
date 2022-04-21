extends Node


#Inventory
var inventory = [null, null, null]

#Bullets
var type_bullet = "standard"
var bullet_amount = 240
var remaining_pistol_bullets = 7
var remaining_smg_bullets = 25
var remaining_shotgun_bullets = 5
var remaining_assault_bullets = 30

#Equipment
var salt_usages = 3


#ITEMS
var pistol = {
	"name" : "Pistol",
	"source" : "res://Equipment/Guns/Pistol.tscn"}
var smg = {
	"name" : "Submachine Gun",
	"source" : "res://Equipment/Guns/Smg.tscn"}
var shotgun = {
	"name" : "Shotgun",
	"source" : "res://Equipment/Guns/Shotgun.tscn"}
var assault = {
	"name" : "Assault Rifle",
	"source" : "res://Equipment/Guns/AssaultRifle.tscn"}
var salt = {
	"name": "Salt Can",
	"source": "res://Equipment/SaltCan.tscn"}

var item_list = [pistol, smg, shotgun, assault, salt]
