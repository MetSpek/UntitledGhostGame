extends KinematicBody2D

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")
var possible_destinations
var path



export var minimum_arrival_distance = 5
export var fov_tolerance = 100
export var max_detection_range = 300

export var hunting = false
export var attack_damage = 10
export var speed = 100
export var hit_points = 100

var player
var velocity

#INTERACTING
export var interacting_motion_sensor = false
export var interacting_salt = false
export var interacting_emf = false
export var interacting_bell = false
export var interacting_uv = false
export var interacting_blessed_book = false
export var interacting_blessed_water = false
export var interacting_blessed_salt = false
export var interacting_blessed_crystal = false
export var cursed_witch_finger = false
export var cursed_doll = false
export var interacting_pistol = false
export var interacting_smg = false
export var interacting_rifle = false
export var interacting_shotgun = false
export var interacting_bullet_standard = false
export var interacting_bullet_silver = false
export var interacting_bullet_salted = false
export var interacting_bullet_holy = false


func _ready():
	player = get_node("/root").find_node("PlayerCharacter", true, false)
	randomize()
	possible_destinations = destinations.get_children()
	make_path()


func _physics_process(delta):
	if player_in_fov() and player_in_los() and hunting:
		look_at_player()
		move_to_player()
	else:
		follow_path()

# MOVEMENT
func make_path():
	if possible_destinations:
		var new_destination = get_position()
		path = navigation.get_simple_path(position, new_destination.position, false)


func follow_path():
	if path:
		move_and_slide((path[0] - global_position).normalized() * speed)
		update_path()

func update_path():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination < minimum_arrival_distance:
		path.remove(0)

func get_position():
	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
	return new_destination

func move_to_player():
	velocity = global_position.direction_to(player.global_position)
	move_and_slide(velocity * speed)


func look_at_player():
	look_at(player.global_position)
	if player.global_position < global_position:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
		

func player_in_fov():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_player = (player.position - global_position).normalized()
	
	if abs(direction_to_player.angle_to(npc_facing_direction)) < deg2rad(fov_tolerance):
		return true
	else:
		return false

func player_in_los():
	var space = get_world_2d().direct_space_state
	var los_obstacle = space.intersect_ray(global_position, player.global_position, [self], collision_mask)
	
	if not los_obstacle:
		return false
	var distance_to_player = player.global_position.distance_to(global_position)
	var player_in_range = distance_to_player < max_detection_range
	
	if los_obstacle.collider == player and player_in_range:
		return true
	else:
		return false

# HUNTING
func _on_AttackRange_body_entered(body):
	if body.has_method("get_damage") and hunting:
		body.get_damage(attack_damage)
		if possible_destinations:
			var new_destination = get_position()
			position = new_destination.position
			stop_hunt()
		

func start_hunt():
	hunting = true
	$Collision.disabled = false

func stop_hunt():
	hunting = false
	$Collision.disabled = true
	print($Collision.disabled)

#INTERACTING
func interact_with_salt():
	print("je moeder")



func get_damage(damage_amount):
	hit_points -= damage_amount
	check_if_dead()

func check_if_dead():
	if hit_points <= 0:
		print("GHOST IS DEAD AF")
