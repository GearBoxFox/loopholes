extends Area3D

@export var speed = 100

func _physics_process(delta: float) -> void:
	position.x += sin(rotation.y) * speed * delta
	position.z += cos(rotation.y) * speed * delta
