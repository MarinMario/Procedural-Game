extends CanvasLayer

onready var p := get_parent()

func _process(delta):
	if p.throw_timer <= 0:
		$ThrowPower.hide()
	else:
		$ThrowPower.show()
		$ThrowPower.value = p.throw_force * p.throw_timer
