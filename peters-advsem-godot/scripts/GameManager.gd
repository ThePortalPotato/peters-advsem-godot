extends Node


var fish: float = 0.0
var fish_per_second: float = 1.0


func _process(delta: float) -> void:
	fish += fish_per_second * delta


func _on_shop_button_pressed() -> void:
	var shop = load("res://scenes/shop-menu.tscn").instantiate()
	$CanvasLayer.add_child(shop)
