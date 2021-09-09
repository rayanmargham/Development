extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var RetryButton = false
var debugForceVR = false
onready var button = $Control/Button
onready var animation = $Control/AnimationPlayer
onready var Error_sound = preload("res://Sounds/UI_SFX/Error.ogg")
onready var loading_sound = preload("res://Sounds/UI_SFX/Searching.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("fade in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if RetryButton == false:
		button.disabled = true
		animation.play("fade out")
	else:
		button.disabled = true
		animation.play("fade out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade out":
		$Control/AudioStreamPlayer.stream = loading_sound
		$Control/AudioStreamPlayer.play()
		$Control/ProgressBar.visible = true
		# basic ui that would be changed in the future
		while (true):
			if $Control/ProgressBar.value == 100:
				$Control/ProgressBar.visible = false
				break
			$Control/ProgressBar.value += 1
			yield(get_tree().create_timer(0.05), "timeout") # basically wait() in godot
		print("DEBUG:LOADING VR INTERFACE")
		var interface = ARVRServer.find_interface("OpenVR")
		if interface and interface.initialize():
#			get_viewport().arvr = true
#			get_viewport().keep_3d_linear = true
#			print("you got in vr congrats")
			print("attempting to switch to test scene")
			get_tree().change_scene("res://Game/Development/TestScene/TestScenel.tscn")
		elif debugForceVR == false:
			$Control/AudioStreamPlayer.stream = Error_sound
			$Control/AudioStreamPlayer.play()
			$Control/RichTextLabel.text = """Virtual Reality Device Not Found
Please make sure your VR Headset is Connected, and Press The Retry Button Below"""
			$Control/RichTextLabel.modulate.a = 1
			# debug purposes
			button.rect_position.y = 500
			button.modulate.a = 1
			RetryButton = true
			button.disabled = false
			button.text = "Retry"
		else:
			get_tree().change_scene("res://Game/Development/TestScene/TestScenel.tscn")
			print("just go")
