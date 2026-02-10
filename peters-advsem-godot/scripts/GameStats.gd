extends Control


@onready var GameManager = $"/root/MainLevel"


func _process(_delta: float) -> void:
	%"Fish Count".text = "Fish: %d" % GameManager.fish
	%"Fish Per Second".text = "%.1f fish/sec" % GameManager.fish_per_second
