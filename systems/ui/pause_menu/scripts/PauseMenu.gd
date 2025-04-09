extends CanvasLayer

signal paused
signal unpaused

var is_paused : bool = false

@export var options_scene : PackedScene
@export var quit_scene : PackedScene

func _ready() -> void:
	hide()
	
	$VBoxContainer/ResumeButton.pressed.connect(unpause)
	$VBoxContainer/OptionsButton.pressed.connect(options)
	$VBoxContainer/QuitButton.pressed.connect(quit_to_menu)
	
	
func pause() -> void:
	is_paused = true
	get_tree().paused = true
	show()
	emit_signal("paused")
	
func unpause() -> void:
	is_paused = false
	get_tree().paused = false
	hide()
	emit_signal("unpaused")
	
func options() ->void:
	## TODO: If options exist in game, connect button to that scene.
	pass
	
func quit_to_menu() -> void:
	
	if quit_scene == null:
		quit_scene = ProjectSettings.get_setting("application/run/main_scene")
	else:
		get_tree().paused = false
		get_tree().change_scene_to_packed(quit_scene)
