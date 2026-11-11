extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var marry = null
@export var player: CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state = states.roam
enum states {dead,running,roam
}
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	match state:
		states.roam:
			roam()
		states.running:
			run()
		states.dead:
			dead()
func dead():
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()
func run():
	pass
func roam():
	marry = get_tree().get_first_node_in_group("player")
	var distance = global_position.distance_to(marry.global_position)
	if distance < 400:
		print("lol")
		if Input.is_action_just_pressed("ui_accept"):
			dead()
	else: print("sabe")
