extends StaticBody2D


func _on_InteractingRange_body_entered(body):
	if body.has_method("interact_with_salt"):
		body.interact_with_salt()
