extends KinematicBody2D

signal scored

# em 2D, pra cima é negativo
const UP = Vector2(0, -1)

# pode utilizar um export var "nome da variavel" para ela ser visivel no editor
const FLY_FORCE = 200
const MAX_FALL_SPEED = 200
const GRAVITY = 10

onready var animation_player = $AnimationPlayer

var motion = Vector2()

func _ready():
	set_physics_process(true)
	pass

func _physics_process(_delta):
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("FLY"):
		motion.y = -FLY_FORCE
		animation_player.play("Fly")
	
	motion = move_and_slide(motion, UP)


func _on_Hitbox_area_entered(area):
	if area.name == "PointArea":
		emit_signal("scored")
		pass


func _on_Hitbox_body_entered(body):
	if body.is_in_group('Wall'):
		queue_free()
		get_tree().reload_current_scene()
