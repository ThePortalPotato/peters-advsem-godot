extends Control


# Child Scenes
var shop = load("res://scenes/shop-menu.tscn").instantiate()
var settings = load("res://scenes/settings-menu.tscn").instantiate()


func _ready() -> void:
	$/root/MainLevel/CanvasLayer.add_child.call_deferred(shop)
	shop.visible = false
	$/root/MainLevel/CanvasLayer.add_child.call_deferred(settings)
	settings.hide()
	
	### UI Update Timer ###
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.autostart = true
	timer.timeout.connect(update_ui)
	add_child(timer)


func update_ui() -> void:
	%"Money Count".text = "Money: $%s" % GameManager.format_number(GameManager.money)
	%"Fish Per Second".text = "%s fish/sec" % GameManager.format_number(GameManager.fish_per_second)


func _on_shop_button_toggled(toggled_on: bool) -> void:
	print("Shop toggled: ", toggled_on)
	shop.visible = toggled_on
	AudioManager.playOneshot2D(FMODEvents.BUTTON_CLICK)


func _on_settings_button_pressed() -> void:
	settings.visible = !settings.visible
	AudioManager.playOneshot2D(FMODEvents.BUTTON_CLICK)
