extends "res://Equipment/Guns/GunTemplate.gd"

func _ready():
	item_name = "Shotgun"
	bullet_count = 10
	bullet_damage_multiplier = 1
	bullet_delay = 2
	bullet_spread = 200
	clip_size = 5
	bullet_remaining = GlobalStats.remaining_shotgun_bullets
	reload_speed = 4
	bullet_type = load("res://Equipment/Guns/Bullets/BulletTemplate.tscn")
	item = load("res://Equipment/DroppedItems/Guns/DroppedShotgun.tscn")
	sprite = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	sound_fire = load("res://Assets/Sounds/Interface/click_001.ogg")
	
	$Sprite.texture = sprite

