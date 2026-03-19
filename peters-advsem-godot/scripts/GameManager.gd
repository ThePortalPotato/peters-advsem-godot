extends Node


# Currency
var money: float = 0.0
var fish_per_second: float = 1.0
var prestige_coins: float = 0.0
var prestige_mult: float = 1.0


# Game
var upgrade_count: Dictionary = {}
var game_active: bool = false
signal prestiged
signal prestige_upgrade_purchased


func _process(delta: float) -> void:
	if game_active:
		money += get_effective_fps() * delta


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


func buy_prestige_upgrade(cost: int, mult: float) -> bool:
	if prestige_coins >= cost:
		prestige_coins -= cost
		prestige_mult += mult
		prestige_upgrade_purchased.emit()
		return true
	return false


func calc_prestige_coins() -> int:
	return int(sqrt(money / 1000))


func prestige() -> void:
	var reward = calc_prestige_coins()
	if reward <= 0:
		return
	prestige_coins += reward
	money = 0
	fish_per_second = 1.0
	upgrade_count = {}
	prestiged.emit()


func get_effective_fps() -> float:
	return fish_per_second * prestige_mult


### Cheats ###
func _input(event: InputEvent) -> void:
	if not OS.has_feature("debug"):
		return
	if event is InputEventKey and event.pressed and event.keycode == KEY_QUOTELEFT:
		money += 1000000
