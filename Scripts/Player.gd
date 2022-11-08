extends KinematicBody2D

signal scored

# em 2D, pra cima é negativo
const UP = Vector2(0, -1)

# pode utilizar um export var "nome da variavel" para ela ser visivel no editor
const FLY_FORCE = 200
const MAX_FALL_SPEED = 200
const GRAVITY = 10

onready var hit_sfx = preload("res://assets/sfx/hit.ogg")

onready var animation_player = $AnimationPlayer
onready var audio_player = get_parent().get_node("AudioStreamPlayer")
onready var score_audio_player = get_parent().get_node("ScoreAudioPlayer")

var motion = Vector2()
var is_playable = true

func _ready():
	set_physics_process(true)
	pass

func _physics_process(_delta):
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("FLY") and is_playable:
		motion.y = -FLY_FORCE
		animation_player.play("Fly")
		audio_player.set_pitch_scale(rand_range(1, 1.5))
		audio_player.play()
	
	motion = move_and_slide(motion, UP)


func game_over():
	if is_playable:
		get_parent().get_node("GameOverTimer").start()
		audio_player.stream = hit_sfx
		audio_player.play()
		is_playable = false

func _on_Hitbox_area_entered(area):
	if area.name == "PointArea" and is_playable:
		emit_signal("scored")
		score_audio_player.play()
		pass
	if area.name == "Floor":
		game_over()


func _on_Hitbox_body_entered(body):
	if body.is_in_group('Wall'):
		game_over()


func _on_GameOverTimer_timeout():
	get_tree().reload_current_scene()

