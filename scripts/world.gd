extends Node2D
var marry = null

@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer = $AudioStreamPlayer2D2
@onready var audio_stream_player_2d_3: AudioStreamPlayer = $AudioStreamPlayer2D3

@onready var ui: Control = $CanvasLayer/ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marry = get_tree().get_first_node_in_group("player")
	ui.updateblood()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


func _on_human_dying() -> void:
	ui.updateblood()
	audio_kill()


func _on_kitty_dying() -> void:
	ui.updateblood()
	audio_kill()


func _on_ratty_dying() -> void:
	ui.updateblood()
	audio_kill()
	
func audio_kill():
	if ! audio_stream_player_2d_2.playing:
		audio_stream_player_2d_2.play()
		await get_tree().create_timer(1).timeout
		audio_stream_player_2d_2.stop()
