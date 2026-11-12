extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var marry = null
@export var player: CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state = states.roam
var target = null
enum states {dead,running,roam
}
func _ready() -> void:
	find_target()
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
	get_tree().queue_delete(self)
func run():
	pass
func find_target():
	target = global_position + Vector2(randf_range(3000,-3000), randf_range(0,0))
	
func roam():
	if target == null:
		return
	marry = get_tree().get_first_node_in_group("player")
	var distance = global_position.distance_to(marry.global_position)
	var direction = (target - global_position).normalized()
	velocity = velocity.move_toward(direction * SPEED,7)
	if distance < 400:
		velocity = direction * 5
		if Input.is_action_just_pressed("enter"):
			dead()
	if global_position.distance_to(target) < 2:
		find_target()
		print("reachedddd dkjdkk")
	move_and_slide()
