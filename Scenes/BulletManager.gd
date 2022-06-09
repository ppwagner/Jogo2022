extends Node2D

func handle_bullet_spawned(bullet, position, direction, who):
	add_child(bullet)
	bullet.who = who
	bullet.global_position = position
	bullet.set_direction(direction)
