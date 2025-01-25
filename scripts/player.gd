extends CharacterBody2D


const SPEED = 300.0
const ACC = 10.0
const JUMP_VELOCITY = -400.0

var motion = Vector2()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if is_on_floor():
		if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = min(motion.x + ACC, SPEED)
		elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			motion.x = max(motion.x - ACC, -SPEED)
		if not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = lerpf(motion.x, 0, 0.45)
		if Input.is_action_just_released("move_left") and Input.is_action_pressed("move_right"):
			if motion.x < 0:
				motion.x = lerpf(motion.x, 0, 0.45)
		if Input.is_action_just_released("move_right") and Input.is_action_pressed("move_left"):
			if motion.x > 0:
				motion.x = lerpf(motion.x, 0, 0.45)
			
	
	if Input.is_action_just_pressed("boost"):
		motion.x = -((get_local_mouse_position().x)) * SPEED/2 * delta
		motion.y = -((get_local_mouse_position().y)) * SPEED/2 * delta
		velocity = motion
	
	velocity.x = motion.x

	move_and_slide()
