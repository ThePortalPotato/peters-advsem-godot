extends Control


var prestige_upgrades = {
	"Lucky Charm": {"cost": 5.0, "mult": 0.25},
	"Ocean's Blessing": {"cost": 25.0, "mult": 1},
	"Midas' Touch": {"cost": 100.0, "mult": 4},
}

func _ready() -> void:
	for button in %"Upgrade List".get_children():
		if button is Button:
			button.pressed.connect(_on_prestige_upgrade_pressed.bind(button.name))

func _on_continue_pressed() -> void:
	GameManager.prestige()
	%"Prestige Warning".hide()
	%"Prestige Upgrades".show()
	update_labels()

func _on_cancel_pressed() -> void:
	hide()

func _on_done_pressed() -> void:
	hide()

func _on_prestige_upgrade_pressed(upgrade_name: String) -> void:
	var upgrade = prestige_upgrades[upgrade_name]
	GameManager.buy_prestige_upgrade(upgrade.cost, upgrade.mult)
	update_labels()

func update_labels() -> void:
	%"Reward Label".text = "You will earn %d Golden Fish" % GameManager.calc_prestige_coins()
	%"Balance Label".text = "Current: %d Golden Fish" % GameManager.prestige_coins
	for button in %"Upgrade List".get_children():
		if button is Button and prestige_upgrades.has(button.name):
			var upgrade = prestige_upgrades[button.name]
			button.text = "%s - %d GF (x%.2f multiplier)" % [button.name, upgrade.cost, upgrade.mult]
			%"Mult Label".text = "Current Multiplier: x%.2f" % GameManager.prestige_mult

func _on_visibility_changed() -> void:
	if visible:
		%"Prestige Warning".show()
		%"Prestige Upgrades".hide()
		%"Reward Label".text = "You will earn %d Golden Fish" % GameManager.calc_prestige_coins()
		%"Balance Label".text = "Current: %d Golden Fish" % GameManager.prestige_coins
		%"Mult Label".text = "Current Multiplier: x%.2f" % GameManager.prestige_mult
