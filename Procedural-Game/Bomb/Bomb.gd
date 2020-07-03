extends RigidBody2D

var tilemap: Node2D

func _on_ExplodeTimer_timeout():
	if tilemap != null:
		var cell_position = tilemap.world_to_map(position)
		var r = range(-1 * (randi() % 5 + 3), randi() % 5 + 3)
		for column in r:
			for row in r:
				var cell := Vector2(cell_position.x + row, cell_position.y + column)
				get_parent().remove_cell(cell)
	queue_free()
	
func _on_DamageArea_body_entered(body):
	if body is TileMap:
		tilemap = body
