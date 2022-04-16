extends "res://Equipment/Guns/GunTemplate.gd"

func _ready():
	item_name = "Assault Rifle"
	bullet_count = 1
	bullet_damage_multiplier = 1
	bullet_delay = 0.15
	bullet_spread = 100
	clip_size = 30
	bullet_remaining = GlobalStats.remaining_assault_bullets
	reload_speed = 2
	bullet_type = load("res://Equipment/Guns/Bullets/BulletTemplate.tscn")
	item = load("res://Equipment/DroppedItems/Guns/DroppedAssault.tscn")
	sprite = load("res://Assets/Sprites/Equipment/Guns/GunTest.png")
	sound_fire = load("res://Assets/Sounds/Interface/click_001.ogg")
	$Sprite.texture = sprite
