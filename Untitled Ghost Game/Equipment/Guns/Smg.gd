extends "res://Equipment/Guns/GunTemplate.gd"

func _ready():
	item_name = "Submachine Gun"
	bullet_count = 1
	bullet_damage_multiplier = 5
	bullet_delay = 0.075
	bullet_spread = 250
	clip_size = 25
	bullet_remaining = GlobalStats.remaining_smg_bullets
	reload_speed = 1.75
	bullet_type = load("res://Equipment/Guns/Bullets/BulletTemplate.tscn")
	item = load("res://Equipment/DroppedItems/Guns/DroppedSmg.tscn")
	sprite = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	sound_fire = load("res://Assets/Sounds/Interface/click_001.ogg")
	$Sprite.texture = sprite
