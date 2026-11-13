extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("new_animation")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
