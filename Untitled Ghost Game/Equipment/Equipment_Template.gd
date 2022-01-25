extends Node2D


func _physics_process(delta):
	look_at_cursor()


func look_at_cursor():
	look_at(get_global_mouse_position())
