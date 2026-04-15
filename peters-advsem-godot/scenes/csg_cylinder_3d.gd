extends Node3D

var speed : Vector3 = Vector3(0,40,0)

func _process(delta: float) -> void:
	rotation_degrees += speed * delta
