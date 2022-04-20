extends Camera2D

# Animate this to increase/decrease/fade the shaking
var shake_amount = .1
var able_to_shake = false

func _process(delta):
	if able_to_shake:
		self.set_offset(Vector2( \
			rand_range(-1.0, 1.0) * shake_amount, \
			rand_range(-1.0, 1.0) * shake_amount \
		))

func change_shake(state):
	able_to_shake = state
