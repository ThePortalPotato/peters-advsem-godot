extends Control

var upgrades = {
   	"Fresh Bait": {"cost": 10.0, "fps": 0.5},
   	"Reel Speed": {"cost": 50.0, "fps": 2.0},
   	"Pole Reinforcement": {"cost": 150.0, "fps": 5.0},
   	"Extra Bobber": {"cost": 500.0, "fps": 15.0},
   	"Protein Shake": {"cost": 1500.0, "fps": 40.0},
   	"Fishing Buddy": {"cost": 5000.0, "fps": 120.0},
   	"Fish Sonar": {"cost": 15000.0, "fps": 350.0},
   	"Buff Arms": {"cost": 50000.0, "fps": 1000.0},
   	"Fishing Net": {"cost": 150000.0, "fps": 2800.0},
   	"Lucky Mullet": {"cost": 500000.0, "fps": 8000.0},
   	"Fishing Boat": {"cost": 1500000.0, "fps": 22000.0},
   	"Creatine IV": {"cost": 5000000.0, "fps": 60000.0},
   	"Fish Magnet": {"cost": 20000000.0, "fps": 160000.0},
   	"Bird Thats Really Good At Catching Fish": {"cost": 75000000.0, "fps": 420000.0},
   	"Tactical Nuke": {"cost": 300000000.0, "fps": 1000000.0},
}


func _ready() -> void:
	for button in %"Upgrade List".get_children():
		if button is Button:
			button.pressed.connect(_on_upgrade_pressed.bind(button.name))
		update_button_labels()


func _on_upgrade_pressed(upgrade_name: String) -> void:
	var upgrade = upgrades[upgrade_name]
	var success: bool
	if Input.is_key_pressed(KEY_SHIFT):
		success = GameManager.buy_upgrade_bulk(upgrade_name, upgrade.cost, upgrade.fps, 10)
	else:
		success = GameManager.buy_upgrade(upgrade_name, upgrade.cost, upgrade.fps)
	if success:
		AudioManager.playOneshot2D(FMODEvents.ITEM_PURCHASE)
	else:
		AudioManager.playOneshot2D(FMODEvents.ERROR)
	update_button_labels()

func update_button_labels() -> void:
	for button in %"Upgrade List".get_children():
		var upgrade = upgrades[button.name]
		var count = GameManager.upgrade_count.get(button.name, 0)
		var cost = upgrade.cost * pow(1.15, count)
		button.text = "%s - $%s (+%s/s)" % [button.name, GameManager.format_number(cost), GameManager.format_number(upgrade.fps)]
