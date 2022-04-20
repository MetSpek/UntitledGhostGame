extends Node2D

var item_name
var bullet_count
var bullet_damage_multiplier
var bullet_delay
var bullet_spread
var clip_size
var bullet_remaining
var reload_speed

var sound_reload = load("res://Assets/Sounds/Guns/reload.mp3")
var sound_fire

const BULLET_SPEED = 1000

var bullet_type
var item
var sprite

var can_shoot = true
var is_reloading = false
var random = RandomNumberGenerator.new()

func _physics_process(delta):
	look_at_cursor()


func look_at_cursor():
	look_at(get_global_mouse_position())
	if get_parent().get_parent().get_local_mouse_position().x < 0:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
	if get_parent().get_parent().get_local_mouse_position().y < 0:
		$Sprite.z_index = -1
	else:
		$Sprite.z_index = 0

func use(position):
	if can_shoot and bullet_remaining > 0 and !is_reloading:
		$GunFire.stream = sound_fire
		$GunFire.play()
		can_shoot = false
		bullet_remaining -= 1
		get_tree().call_group("BulletCount", "update_bullet_count", bullet_remaining)
		for x in range(bullet_count):
			var bullet_instance = bullet_type.instance()
			random.randomize()
			var spread = random.randi_range(-bullet_spread, bullet_spread)
			get_tree().get_root().get_node("LevelTemplate").add_child(bullet_instance)
			bullet_instance.bullet_damage = bullet_instance.bullet_damage * bullet_damage_multiplier
			bullet_instance.global_position = $GunPoint.global_position
			bullet_instance.rotation = global_rotation
			bullet_instance.apply_impulse(Vector2(), Vector2(BULLET_SPEED, spread).rotated(rotation))
		get_tree().call_group("PlayerCamera", "change_shake", true)
		$CameraShake.start()
		$BulletCooldown.wait_time = bullet_delay
		$BulletCooldown.start()

		

func reload():
	is_reloading = true
	$GunFire.stream = sound_reload
	$GunFire.play()
	get_tree().call_group("BulletCount", "update_bullet_count", bullet_remaining)
	if GlobalStats.bullet_amount >= clip_size:
		GlobalStats.bullet_amount -= (clip_size - bullet_remaining)
		yield(get_tree().create_timer(reload_speed),"timeout")
		bullet_remaining = clip_size
		print(str(GlobalStats.bullet_amount) + " Bullts Remaining")
	elif GlobalStats.bullet_amount > 0 and GlobalStats.bullet_amount < clip_size:
		yield(get_tree().create_timer(reload_speed),"timeout")
		bullet_remaining += GlobalStats.bullet_amount
		GlobalStats.bullet_amount -= bullet_remaining
		print(str(GlobalStats.bullet_amount) + " Bullts Remaining")
	get_tree().call_group("BulletCount", "update_bullet_count", bullet_remaining)
	is_reloading = false

func show_bullets():
	get_tree().call_group("BulletCount", "show_bullet_count")
	get_tree().call_group("BulletCount", "update_bullet_count", bullet_remaining)

func hide_bullets():
	get_tree().call_group("BulletCount", "hide_bullet_count")

func drop(position):
	var item_instance = item.instance()
	item_instance.global_position = position
	get_tree().get_root().get_node("LevelTemplate").get_node("Props").add_child(item_instance)
	
	match item.instance().name:
		"DroppedPistol":
			GlobalStats.remaining_pistol_bullets = bullet_remaining
		"DroppedSmg":
			GlobalStats.remaining_smg_bullets = bullet_remaining
		"DroppedShotgun":
			GlobalStats.remaining_shotgun_bullets = bullet_remaining
		"DroppedAssault":
			GlobalStats.remaining_assault_bullets = bullet_remaining
	queue_free()



func _on_BulletCooldown_timeout():
	can_shoot = true
	


func _on_CameraShake_timeout():
	get_tree().call_group("PlayerCamera", "change_shake", false)

