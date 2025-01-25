extends CharacterBody2D


const SPEED = 300.0
const ACC = 20.0
const JUMP_VELOCITY = -400.0
const MAX_BOOSTS = 1

var has_boost_wand = false
var motion = Vector2()
var is_killed = false
var boosts_used = 0

func _input(event):
	if is_killed:
		return

func _physics_process(delta: float) -> void:	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle floor left/right movement.
	if is_on_floor():
		# Reset air boosts
		boosts_used = 0
		# Move right if pressing right
		if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = min(motion.x + ACC, SPEED)
		# Move left if pressing left
		elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			motion.x = max(motion.x - ACC, -SPEED)
		# Ease to 0 if not pressing either
		if not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = lerpf(motion.x, 0, 0.15)
		# If left is released and moving right
		if Input.is_action_just_released("move_left") and Input.is_action_pressed("move_right"):
			if motion.x < 0:
				motion.x = lerpf(motion.x, 0, 0.45)
		# If right is released and moving left
		if Input.is_action_just_released("move_right") and Input.is_action_pressed("move_left"):
			if motion.x > 0:
				motion.x = lerpf(motion.x, 0, 0.45)
	# Handle air left-right movement
	else:
		# Move right if pressing right
		if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = min(motion.x + ACC, SPEED)
		# Move left if pressing left
		elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			motion.x = max(motion.x - ACC, -SPEED)
		# Ease to 0 if not pressing either
		if not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			motion.x = lerpf(motion.x, 0, 0.15)
		# If left is released and moving right
		if Input.is_action_just_released("move_left") and Input.is_action_pressed("move_right"):
			if motion.x < 0:
				motion.x = lerpf(motion.x, 0, 0.45)
		# If right is released and moving left
		if Input.is_action_just_released("move_right") and Input.is_action_pressed("move_left"):
			if motion.x > 0:
				motion.x = lerpf(motion.x, 0, 0.05)
	
	# Handle boost wand movement
	if Input.is_action_just_pressed("boost") and boosts_used < MAX_BOOSTS and has_boost_wand:
		motion.x = -((get_local_mouse_position().x)) * SPEED * delta
		motion.y = -((get_local_mouse_position().y)) * SPEED * delta
		if motion.x > 500:
			motion.x = 500
		elif motion.x < -500:
			motion.x = -500
		if motion.y > 500:
			motion.y = 500
		elif motion.y < -500:
			motion.y = -500
		boosts_used += 1
		velocity = motion
	
	velocity.x = motion.x

	if is_killed:
		set_process_input(false)
		motion = Vector2.ZERO
		velocity = Vector2.ZERO
	else:
		set_process_input(true)
	

	move_and_slide()
