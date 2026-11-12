extends Node2D
var marry = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marry = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
