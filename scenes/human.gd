extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var marry = null
@export var player: CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state = states.roam
enum states {idel,running,roam
}
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	match state:
		states.roam:
			roam()
		states.running:
			run()
func run():
	pass
func roam():
	marry = get_tree().get_first_node_in_group("player")
	var distance = global_position.distance_to(marry.global_position)
	if distance < 400:
		print("lol")
		if Input.is_action_just_pressed("ui_accept"):
			animation_player.play("death")
			await get_tree().create_timer(5).timeout
			get_tree().queue_delete(self)
	else: print("sabe")
