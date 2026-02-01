extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -700.0

# Get a reference to the AnimatedSprite2D node
@onready var sprite = $AnimatedSprite2D
var isPeeing: bool = false

func _physics_process(delta: float) -> void:
	if isPeeing:
		sprite.play("pee")
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var idle_animation: String
	var running_animation: String
	
	match MaskManager.current_mask:
		MaskManager.MaskType.FOG:
			idle_animation = "idle_fog_mask"
			running_animation = "running_fog_mask"
		MaskManager.MaskType.DRUNK:
			idle_animation = "idle_drunk_mask"
			running_animation = "running_drunk_mask"
		_:
			idle_animation = "idle"
			running_animation = "running"

	if direction != 0:
		sprite.play(running_animation)
	else:
		sprite.play(idle_animation)

	# FLIP LOGIC (Make the character face the right way)
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider == $"../Death":
			get_tree().quit()

func _on_timer_timeout() -> void:
	$AudioStreamPlayer2D.play()
	
func pee():
	MaskManager.change_mask(MaskManager.MaskType.DEFAULT)
	isPeeing = true
	await sprite.animation_finished
	isPeeing = false
