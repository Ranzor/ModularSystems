extends MarginContainer
func _ready():
	var animation = $AnimationPlayer

func _on_animation_player_animation_finished(load_splash_screen):
	get_tree().change_scene_to_file("res://main_menu.tscn")
