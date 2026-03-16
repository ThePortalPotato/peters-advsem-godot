extends Control


func _ready() -> void:
	%"Master Slider".value = AudioManager.master_volume
	%"Music Slider".value = AudioManager.music_volume
	%"SFX Slider".value = AudioManager.sfx_volume


func _on_master_slider_value_changed(value: float) -> void:
	AudioManager.master_volume = value
	AudioManager.set_bus_volume("bus:/", value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.music_volume = value
	AudioManager.set_bus_volume("bus:/Music", value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioManager.sfx_volume = value
	AudioManager.set_bus_volume("bus:/SFX", value)


func _on_back_button_pressed() -> void:
	hide()
	AudioManager.playOneshot2D(FMODEvents.BUTTON_CLICK)
