extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal dying
var marry = null
@export var player: CharacterBody2D
var SPEED = 300.0
var running_speed = 500.0
const JUMP_VELOCITY = -400.0
var state = null
var target = null
var died = false
enum states {dead,running,roam
}
func _ready() -> void:
	find_target()
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	match state:
		states.roam:
			roam(delta)
		states.running:
			run(delta)
		states.dead:
			dead()

#here use ai , not to generate code but to debug and get the idea as all enemies were dying at the same time
func find_nearest_kill():
	var smallest_dis = INF
	var closekill = null
	
	var kills = get_tree().get_nodes_in_group("kills")
	for kill in kills:
		if !is_instance_valid(kill):
			continue
		
		var distance = marry.global_position.distance_to(kill.global_position)
		if distance < smallest_dis:
			smallest_dis = distance
			closekill = kill
			
	for kill in kills:
		if is_instance_valid(kill):
			kill.get_node("AnimatedSprite2D").modulate = Color(1.0, 1, 1, 1.0)
		if is_instance_valid(closekill):
			closekill.get_node("AnimatedSprite2D").modulate = Color(0.911, 0.0, 0.0, 1.0)
			
	return closekill
func dead():
	if died:
		return
	died = true
	remove_from_group("kills")
	velocity = Vector2.ZERO
	Gamemanager.blood += 1
	print(Gamemanager.blood)
	dying.emit()
	print('killili')
	queue_free()
func run(delta):
	print("runnninfh")
	var direction = (global_position - marry.global_position).normalized()
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	if direction.x < 0:
		animated_sprite_2d.flip_h = true
	velocity.x = direction.x * running_speed
	if global_position.distance_to(marry.global_position) < 1200:
		var closest = find_nearest_kill()
		if Input.is_action_just_pressed("enter"):
			
			if closest == self:
				state = states.dead
	else:
		find_target()
	
	move_and_slide()
func find_target():
	target = global_position + Vector2(randf_range(-3000,3000),0)
	state = states.roam
	print("target findee
	s
	s")
	
func roam(delta):
	if target == null:
		return
	marry = get_tree().get_first_node_in_group("player")
	var distance = global_position.distance_to(marry.global_position)
	var direction = (target - global_position).normalized()
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	if direction.x < 0:
		animated_sprite_2d.flip_h = true
	velocity = velocity.move_toward(direction * SPEED,700 * delta)
	if distance < 400:
		state = states.running
		velocity = direction * 5
	if global_position.distance_to(target) < 150:
		velocity = Vector2.ZERO
		find_target()
		print("reachedddd dkjdkk")
		return
	move_and_slide()
