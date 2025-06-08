extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@onready var label_3d = $"../Sketchfab_Scene/MeshInstance3D/Label3D"
@onready var animation_player = $"../Camera3D/AnimationPlayer"
@onready var good = $"../../../G"

func _on_pressed():
	animation_player.play("Turn around")
	visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'Turn around' and label_3d.text == '_':
		label_3d.text = InteractableNpc.load_from_file('assets/credits.txt')
		good.play()
		animation_player.play_backwards("Turn around")
