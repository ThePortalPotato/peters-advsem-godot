extends Node

var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0

func set_bus_volume(bus_name: String, value: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func playOneshot2D(stream: AudioStream) -> void:
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.bus = "SFX"
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)
