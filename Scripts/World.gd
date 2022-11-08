extends Node2D

const WALL = preload("res://Scenes/WallNode.tscn")

var score = 0
func _ready():
	pass


func wall_spawner():
	var wall_instance = WALL.instance()
	wall_instance.position = Vector2(700, rand_range(-60,60))
	$Pipes.call_deferred('add_child', wall_instance)
	pass

func _on_Resetter_body_entered(body):
	if body.is_in_group('Wall'):
		body.queue_free()
		wall_spawner()


func _on_Player_scored():
	score += 1
	$HUD/Label.text = str(score)
	pass # Replace with function body.


func _on_Floor_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		get_tree().reload_current_scene()
