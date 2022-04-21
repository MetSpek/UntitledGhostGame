extends RigidBody2D

var bullet_damage = 1
var bullet_type = GlobalStats.type_bullet

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.has_method("get_damage"):
		body.get_damage(bullet_damage, bullet_type)
	queue_free()
