extends Node


# Fish floats 
# To-do make global
var money: float = 0.0
var fish_per_second: float = 1.0
var upgrade_count: Dictionary = {}
var game_active: bool = false


func _process(delta: float) -> void:
	if game_active:
		money += fish_per_second * delta

func format_number(value: float) -> String:
	if value < 1000:
		return "%.1f" % value
	elif value < 1000000:
		return "%.1fK" % (value / 1000.0)
	elif value < 1000000000:
		return "%.1fM" % (value / 1000000.0)
	else:
		return "%.1fB" % (value / 1000000000.0)


func buy_upgrade(upgrade_name: String, base_price: float, fps_increase: float) -> bool:
	var count = upgrade_count.get(upgrade_name, 0)
	var current_cost = base_price * pow(1.15, count)
	if money >= current_cost:
		money -= current_cost
		fish_per_second += fps_increase
		upgrade_count[upgrade_name] = count + 1
		return true
	return false


func buy_upgrade_bulk(upgrade_name: String, base_cost: float, fps_increase: float, amount: int) -> int:
	var bought = 0
	for i in range(amount):
		if buy_upgrade(upgrade_name, base_cost, fps_increase):
			bought += 1
		else:
			break
	return bought
