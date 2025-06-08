extends Camera3D

var walk_speed:float
var sprint_speed:float

var jump_power:float
var jump_boost:float

var ground_accelaration:float = 5
var ground_decelaration:float = 5
var air_control:float=2
var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")

var bob_freq := 2.5
var bob_amp := 0.1
var base_FOV:= 30.0
var FOV_change := 1.5
var sens := 0.01

#Movement
var target_speed:float
@onready var input_dir:Vector2
var dir:Vector3
#Cam Shake
var current_rotation:Vector3
var target_rotation:Vector3
#Cam Shake Settings
var snap:float
var return_speed:float
#Cam Shake Strength
var shake_strength:Vector3
#Keep Track of Sine Wave
var bob_time:float = 0.0
#State Machine
enum states {walk, sprint}
var state:states

#Lock Mouse
func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

#Input
func _input(event):
	#Character Rotation
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		# rotate_x (deg_to_rad(-event.relative.y * sens))
		# rotation.x = clamp(rotation.x,deg_to_rad(-90),deg_to_rad(90))

#Movement
func _physics_process(delta:float) -> void:
	#FOV
	var velocity_clamped = clamp(3, 0.5, sprint_speed * 2)
	var target_fov = base_FOV + FOV_change * velocity_clamped
	fov = lerp(fov, target_fov, delta * 8.0)

func _process(delta:float) -> void:
	target_rotation = target_rotation.slerp(Vector3.ZERO, return_speed * delta)
	current_rotation = current_rotation.slerp(target_rotation, snap * delta)
