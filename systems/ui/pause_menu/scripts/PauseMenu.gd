extends CanvasLayer

signal paused
signal unpaused

var is_paused : bool = false

const PAUSE_ACTION : String = "pause_menu_toggle"

@export_category("Buttons")
@export var resume_button : Button
@export var options_button : Button
@export var quit_to_menu_button : Button


@export_category("Target Scenes")
## The scene to load when the "Options" button is pressed.[br]
## Drag your Options scene here (e.g., Options.tscn).
@export var options_scene : PackedScene
## The scene to load when the "Quit to Menu" button is pressed.[br]
## Drag your main menu scene here (e.g., MainMenu.tscn).
@export var quit_scene : PackedScene

@export_category("Utility")
## Put key binds here to override defauls. [br]
## if empty, defaults to Escape key.
@export var default_pause_events: Array[InputEvent] = []

## Toggle between ingame options window and full scene change [br]
## ON = Windowed OFF = scene-change
@export var windowed_options : bool = true

func _ready() -> void:
	
	hide()
	
	resume_button.pressed.connect(unpause)
	options_button.pressed.connect(options)
	quit_to_menu_button.pressed.connect(quit_to_menu)
	
	if default_pause_events.is_empty():
		var event = InputEventKey.new()
		event.keycode = KEY_ESCAPE
		default_pause_events.append(event)
		
	InputHandler.register_action(PAUSE_ACTION, default_pause_events)
	InputHandler.action_pressed.connect(_on_action_pressed)
	
	
	
func pause() -> void:
	
	is_paused = true
	get_tree().paused = true
	show()
	set_process_input(true)
	resume_button.grab_focus()
	
	emit_signal("paused")
	
func unpause() -> void:
	
	is_paused = false
	get_tree().paused = false
	set_process_input(false)
	hide()
	emit_signal("unpaused")
	
func options() ->void:
	
	if not options_scene:
		push_warning("PauseMenu: no option scene assigned. Drag scene into Options Scene variable to enable")
		options_button.disabled = true
	else:
		if windowed_options:
			var options_instance = options_scene.instantiate()
			add_child(options_instance)
			hide()
		else:
			get_tree().paused = false
			hide()
			get_tree().change_scene_to_packed(options_scene)
	
func quit_to_menu() -> void:
	
	var target_scene : PackedScene
	
	if quit_scene:
		target_scene = quit_scene
	else:
		var main_scene_path : String = ProjectSettings.get_setting("application/run/main_scene")
		target_scene = load(main_scene_path) as PackedScene
		push_warning("PauseMenu: no quit scene assigned. Drag scene into Quit Scene variable to enable DEFAULT: main_scene")
	
	if target_scene:
		get_tree().paused = false
		hide()
		get_tree().change_scene_to_packed(target_scene)
	else:
		push_warning("PauseMenu: no quit scene assigned. Drag scene into Quit Scene variable to enable")
		
func _on_action_pressed(action: String, _strength: float):
	
	if action == PAUSE_ACTION:
		pause()
