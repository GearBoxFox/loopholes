extends Node3D

var arrow_base = preload("res://scenes/weapons/arrow.tscn")
var enemy = preload("res://scenes/enemies/soldier.tscn")

@export var num_enemies = 5

var spawned_enemies = 0

@onready var enemy_container = $EnemyContainer
@onready var enemy_spawns = $EnemySpawn.get_children()
@onready var enemy_target = $Targets/Marker3D

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if enemy_container.get_child_count() == 0 and spawned_enemies == num_enemies:
		pass

func _on_player_spawn_projectile(location: Marker3D, draw_percentage: float) -> void:
	var arrow = arrow_base.instantiate()
	add_child(arrow)
	arrow.position = location.global_position 
	
	# rotate arrow based on camera position
	arrow.rotation = location.get_parent().global_rotation + Vector3(0.0, 3.141, 3.141)
	arrow.rotation.x = -arrow.rotation.x
	
	arrow.init(draw_percentage)
	


func _on_enemy_spawn_timer_timeout() -> void:
	# if we've spawned all enemies this round, don't spawn more
	if num_enemies == spawned_enemies:
		return
	
	# spawn new enemy at random spawn position
	var spawn_index = randi_range(0, enemy_spawns.size())
	var spawn_pose = enemy_spawns[spawn_index]
	var new_enemy = enemy.instantiate()
	enemy_container.add_child(new_enemy)
	new_enemy.global_position = spawn_pose.global_position
	
	# increment the number of spawned enemies
	spawned_enemies += 1
	new_enemy.set_movement_target(enemy_target.global_position)
	
