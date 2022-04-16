extends RigidBody2D

var bullet_damage = 1

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	queue_free()
