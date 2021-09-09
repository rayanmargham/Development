extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var interface = ARVRServer.find_interface("OpenVR")
	if interface and interface.initialize():
		get_viewport().arvr = true
		get_viewport().keep_3d_linear = true
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
		print("welcome to vr")
		print("take off at the speed of " + str(Engine.iterations_per_second))
		print("and take a chance on today! with " + str(OS.vsync_enabled))
		print("so high that we can kiss the sky")
	else:
		OS.shell_open("https://www.youtube.com/watch?v=MTRpmKQntHI")


func _on_left_button_pressed(button):
	print("button pressed: " + str(button))
	$ARVROrigin/left.rumble += 10
