extends RigidBody2D

var tilemap: Node2D
var speed := 500

func _ready():
	var impulse = (get_global_mouse_position() - global_position).normalized()
	apply_impulse(Vector2.ZERO, impulse * speed)

func explode():
	if tilemap != null:
		var cell_position = tilemap.world_to_map(position)
		var r = range(-5, 5)
		for column in r:
			for row in r:
				var cell := Vector2(cell_position.x + row, cell_position.y + column)
				get_parent().remove_cell(cell)
	spawn_explosion()
	queue_free()
	
func _on_DamageArea_body_entered(body):
	if body is TileMap:
		tilemap = body

func spawn_explosion():
	var explosion = Global.EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)

func _on_ExplodeTimer_timeout():
	explode()
