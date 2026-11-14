extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func audio():
	audio_stream_player_2d.play()
func _ready() -> void:
	animation_player.play("new_animation")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
