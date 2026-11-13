extends Node2D
var marry = null
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
		queue_free()


func _on_human_dying() -> void:
	ui.updateblood()


func _on_kitty_dying() -> void:
	ui.updateblood()


func _on_ratty_dying() -> void:
	ui.updateblood()
