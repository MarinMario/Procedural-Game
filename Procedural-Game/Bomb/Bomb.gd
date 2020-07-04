extends RigidBody2D

var tilemap: TileMap
var colliding_bomb: RigidBody2D
export var speed := 500
export var destroy_range := 3
export var impulse_force = 5000

func _ready():
	var impulse = (get_global_mouse_position() - global_position).normalized()
	apply_impulse(Vector2.ZERO, impulse * speed)
	$AnimationPlayer.play("count_down")

func explode():
	if tilemap != null:
		var cell_position = tilemap.world_to_map(position)
		for column in range(-destroy_range, destroy_range):
			for row in range(-destroy_range, destroy_range):
				var cell := Vector2(cell_position.x + row, cell_position.y + column)
				tilemap.set_cellv(cell, -1)
	if colliding_bomb != null:
		var impulse = (colliding_bomb.global_position - global_position).normalized()
		colliding_bomb.apply_impulse(Vector2.ZERO, impulse * impulse_force)
	spawn_explosion()
	queue_free()
	
func _on_DamageArea_body_entered(body):
	if body is TileMap:
		tilemap = body
	elif body is RigidBody2D:
		colliding_bomb = body

func spawn_explosion():
	var explosion = Global.EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)

func _on_ExplodeTimer_timeout():
	explode()
