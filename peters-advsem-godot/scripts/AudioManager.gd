extends Node

var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0

func set_bus_volume(bus_path: String, value: float) -> void:
	var bus = FmodServer.get_bus(bus_path)
	bus.set_volume(value)
