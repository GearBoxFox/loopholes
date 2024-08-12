extends Area3D

@export var speed = 100

var y_velocity = 0

var has_collided: bool = false
var velocity: Vector3 = Vector3.ZERO

var prev_pose: Vector2 = Vector2.ZERO

@onready var player = get_parent().get_node("Player")
@onready var arrow_mesh = $ArrowMesh

func init() -> void:
	velocity.y = -sin(rotation.x) * speed
	velocity.x = sin(rotation.y) * cos(rotation.x) * speed
	velocity.z = cos(rotation.y) * cos(rotation.x) * speed
	
	prev_pose = Vector2(global_position.x, global_position.y)

func _physics_process(delta: float) -> void:
	# only move if not collided with a wall
	if !has_collided:
		# calculate new position
		position.x += velocity.x * delta
		position.z += velocity.z * delta
		position.y += velocity.y * delta
	
		velocity.y -= gravity * delta * 4
		
		# Calculate angle based on pose delta
		rotation.x = -asin(velocity.y / speed)
		
	# scale according to distance from player
	var distance = (global_position - player.global_position).length()
	var scaler = 2 * pow(log(distance), 3)
	arrow_mesh.scale = Vector3.ONE * scaler


func _on_body_entered(body: Node3D) -> void:
	if !body.is_in_group("enemy") and !body.is_in_group("player"):
		has_collided = true
