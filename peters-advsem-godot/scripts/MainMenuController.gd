extends Control


var main_level = "res://scenes/main-level.tscn"
var options = load("res://scenes/settings-menu.tscn").instantiate()


func _ready() -> void:
	$ButtonContainer/StartButton.grab_focus()
	add_child(options)
	options.hide()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(main_level)
	AudioManager.playOneshot2D(FMODEvents.BUTTON_CLICK)


func _on_options_button_pressed() -> void:
	options.visible = !options.visible
	AudioManager.playOneshot2D(FMODEvents.BUTTON_CLICK)
