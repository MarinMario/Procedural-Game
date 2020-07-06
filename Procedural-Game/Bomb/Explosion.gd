extends Node2D


func _ready():
	$AnimationPlayer.play("start")

func _on_AnimationPlayer_animation_finished(_anim_name):
	self.queue_free()
