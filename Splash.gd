extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var g = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()



func _on_Timer_timeout():
	match g:
		0:
			$AnimatedSprite/AnimationPlayer.play("splash")
		5:
			get_tree().change_scene("res://Game/Menus/Loading/Loading.tscn")
	g += 1


#func _on_AnimationPlayer_animation_finished(anim_name):
#	get_tree().change_scene("res://Game/Menus/Loading/Loading.tscn")
