extends "res://Equipment/Guns/GunTemplate.gd"

func _ready():
	item_name = "Pistol"
	bullet_count = 1
	bullet_damage_multiplier = 1
	bullet_delay = 1
	bullet_spread = 1
	clip_size = 7
	bullet_remaining = GlobalStats.remaining_pistol_bullets
	reload_speed = 1.5
	bullet_type = load("res://Equipment/Guns/Bullets/BulletTemplate.tscn")
	item = load("res://Equipment/DroppedItems/Guns/DroppedPistol.tscn")
	sprite = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	sound_fire = load("res://Assets/Sounds/Interface/click_001.ogg")
	$Sprite.texture = sprite
	
