extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var moving = true
var jumping:bool 
func animation():
	if Input.is_action_just_pressed("ui_accept"):
		if moving:
			animated_sprite_2d.play("jump mov")
		else:
			animated_sprite_2d.play("jumpidel")
	if jumping:
		return
	if Input.is_action_just_pressed("left"):
		animated_sprite_2d.flip_h = true
	if Input.is_action_just_pressed("right"):
		animated_sprite_2d.flip_h = false
	if moving:
		animated_sprite_2d.play("walking")
	else :
		animated_sprite_2d.play("idel")
	if Input.is_action_just_pressed("left"):
		pass
	
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta + Vector2(5,10)
	animation()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 2
		jumping = true
	if direction:
		velocity.x = direction * SPEED
		moving = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		moving = false
		
	if jumping and is_on_floor():
		jumping = false
	move_and_slide()
