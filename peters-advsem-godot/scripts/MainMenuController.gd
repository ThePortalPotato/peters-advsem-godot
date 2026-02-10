extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main-level.tscn")


func _on_options_button_pressed() -> void:
	var options = load("res://scenes/settings-menu.tscn").instantiate()
	get_tree().current_scene.add_child(options)
