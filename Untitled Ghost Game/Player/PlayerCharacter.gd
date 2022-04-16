extends KinematicBody2D

var item = load("res://Player/PlayerGhost.tscn")

#STATS
var hit_points = 20

#MOVEMENT
var movement_speed = 200
var velocity = Vector2()

#INVENTORY
var player_inventory
var item_slot = 0
var currently_holding 

#INTERACTING
var interacting = []
var closest_interaction

func _ready():
	player_inventory = GlobalStats.inventory
	print(player_inventory)
	currently_holding = player_inventory[item_slot]
	get_tree().call_group("UI", "check", item_slot + 1)

func _physics_process(delta):
	if hit_points > 0:
		choose_closest_object(interacting)
		look_at_cursor()
		get_input()
		animate()	
		velocity = move_and_slide(velocity)
		if Input.is_action_pressed("Use"):
			use_item(currently_holding)



func _unhandled_input(event):
	if event.is_action_pressed("Drop"):
		drop_object()
	elif event.is_action_pressed("Reloading"):
		reload_weapon(currently_holding)
	elif event.is_action_pressed("Interact"):
		interact_with_object(interacting)
	elif event.is_action_pressed("Flashlight"):
		toggle_flashlight()
	elif event.is_action_pressed("Inventory_Up"):
		switch_holding("up")
	elif event.is_action_pressed("Inventory_Down"):
		switch_holding("down")

#MOVEMENT
func look_at_cursor():
	$Flashlight.look_at(get_global_mouse_position())
	if get_local_mouse_position().x < 0:
		$PlayerAnimation.flip_h = true
	else:
		$PlayerAnimation.flip_h = false
#	if get_local_mouse_position().y < 0:
#		$Flashlight.range_z_max = 0
#	else:
#		$Flashlight.range_z_max = 1

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

func animate():
	if get_local_mouse_position().y > 0:
		if velocity:
			$PlayerAnimation.play("walking")
		else:
			$PlayerAnimation.play("idle")
	else:
		if velocity:
			$PlayerAnimation.play("walkingback")
		else:
			$PlayerAnimation.play("idleback")

		
	#INTERACTING
func _on_Interacting_Range_body_entered(body):
	interacting.append(body)

func _on_Interacting_Range_body_exited(body):
	interacting.remove(interacting.find(body))

func interact_with_object(body):
	if body:
		choose_closest_object(body)
		if closest_interaction.has_method("use"):
			closest_interaction.use()
		else:
			pickup_item(closest_interaction)
	else:
		print("No object to interact with")

func choose_closest_object(body):
	if body:
		for x in body:
			if not closest_interaction:
				closest_interaction = x
			else:
				if x.get_global_position().distance_to(global_position) < closest_interaction.get_global_position().distance_to(global_position):
					closest_interaction = x
		get_tree().call_group("UI", "show_interaction", closest_interaction.object_name)
	else:
		get_tree().call_group("UI", "hide_interaction")
		closest_interaction = null


#INVENTORY
func switch_holding(direction):
	if player_inventory.size() > 0:
		match direction:
			"up":
				if item_slot < player_inventory.size() - 1:
					item_slot += 1
				else:
					item_slot = 0
			"down":
				if item_slot > 0:
					item_slot -= 1
				else:
					item_slot = player_inventory.size() - 1
				
		currently_holding = player_inventory[item_slot]
		
		if currently_holding.has_method("show_bullets"):
			currently_holding.show_bullets()
		else:
			get_tree().call_group("BulletCount", "hide_bullet_count")
		
		show_holding()
		get_tree().call_group("UI", "check", item_slot + 1)
		print("Currently holding: " + str(GlobalStats.inventory[item_slot]))
		

func show_holding():
	for x in $Inventory.get_children():
		if x == currently_holding:
			x.visible = true
		elif currently_holding == null:
			get_tree().call_group("BulletCount", "hide_bullet_count")
		else:
			x.visible = false
	
	

func pickup_item(object):
	if currently_holding == null:
		if object.has_method("pickup"):
			object.pickup(item_slot)
			currently_holding = player_inventory[item_slot]
			print("now holding: " + str(GlobalStats.inventory[item_slot]))
			closest_interaction = null
			object.queue_free()
	else:
		for i in GlobalStats.inventory.size():
			if GlobalStats.inventory[i] == null:
				if object.has_method("pickup"):
					object.pickup(i)
					closest_interaction = null
					object.queue_free()
					return

func drop_object():
	if currently_holding != null:
		if currently_holding.has_method("drop"):
			currently_holding.drop(global_position)
			player_inventory[item_slot] = null
			currently_holding = null

#ITEMS
func toggle_flashlight():
	if $Flashlight:
		$Flashlight.visible = !$Flashlight.visible

func use_item(item):
	if item:
		if item.has_method("use"):
			item.use(global_position)

func reload_weapon(item):
	if item:
		if item.has_method("reload"):
			item.reload()

#DAMAGE
func get_damage(damage):
	hit_points = Damage.apply_damage(hit_points, damage)
	check_if_dead()

func check_if_dead():
	if hit_points <= 0:
		var ghost_instance = item.instance()
		$AnimationPlayer.play("Death")
		ghost_instance.global_position = global_position
		get_tree().get_root().get_child(2).add_child(ghost_instance)
		get_tree().get_root().get_child(2).move_child(ghost_instance, 0)
		$Hitbox.disabled = true
		$Interacting_Range/Interacting.disabled = true
		






