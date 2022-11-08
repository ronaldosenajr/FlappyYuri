extends KinematicBody2D

var wall_velocity = Vector2(-100, 0)

func _ready():
	pass

func _physics_process(_delta):
	move_and_slide(wall_velocity, Vector2(-1, 0))
