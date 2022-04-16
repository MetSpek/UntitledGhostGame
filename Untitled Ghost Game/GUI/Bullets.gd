extends Control

func update_bullet_count(bullets):
	$BulletCount.text = str(bullets) + "/" + str(GlobalStats.bullet_amount)

func hide_bullet_count():
	$BulletCount.visible = false

func show_bullet_count():
	$BulletCount.visible = true
