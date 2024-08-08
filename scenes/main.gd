extends Node3D

var arrow_base = preload("res://weapons/arrow.tscn")

func _on_player_spawn_projectile(location: Marker3D) -> void:
	var arrow = arrow_base.instantiate()
	add_child(arrow)
	arrow.scale = Vector3(40, 40, 40)
	arrow.position = location.global_position 
	arrow.rotation = location.get_parent().global_rotation + Vector3(0.0, 3.141, 3.141)
	arrow.rotation.x = -arrow.rotation.x
