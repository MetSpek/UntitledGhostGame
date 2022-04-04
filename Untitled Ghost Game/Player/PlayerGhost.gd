extends KinematicBody2D

#MOVEMENT
var movement_speed = 200
var velocity = Vector2()

func _physics_process(delta):
	if get_local_mouse_position().x < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	get_input()
	velocity = move_and_slide(velocity)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Walk_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Walk_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Walk_Down"):
		velocity.y += 1
	if Input.is_action_pressed("Walk_Up"):
		velocity.y -= 1
	velocity = velocity.normalized() * movement_speed
