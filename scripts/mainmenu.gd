extends Control

@onready var texture_button: TextureButton = $TextureButton
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $AudioStreamPlayer2D3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player_2d.play()
	audio_stream_player_2d_2.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_button_down() -> void:
	texture_button.scale = texture_button.scale * 1.1
	texture_button.modulate = Color(0.619, 0.619, 0.619, 1.0)
	texture_button.position -= Vector2(15,0)
	


func _on_texture_button_button_up() -> void:
	texture_button.position += Vector2(15,0)
	texture_button.scale = texture_button.scale/ 1.1
	texture_button.modulate = Color(1,1,1,1)


func _on_texture_button_mouse_entered() -> void:
	texture_button.modulate = Color(0.898, 0.898, 0.898, 1.0)


func _on_texture_button_mouse_exited() -> void:
	texture_button.modulate = Color(1,1,1,1)


func _on_texture_button_pressed() -> void:
	audio_stream_player_2d_3.play()
	await audio_stream_player_2d_3.finished
	get_tree().change_scene_to_file("res://scenes/world.tscn")
