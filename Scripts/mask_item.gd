extends Area2D

@export var mask_type: MaskManager.MaskType
@export var float_amplitude: float = 10.0
@export var float_speed: float = 2.0

var _initial_y: float
var _time_passed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initial_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_time_passed += delta
	
	# Calculate the new Y offset using a Sine wave
	# Formula: base_y + sin(time * speed) * amplitude
	var y_offset = sin(_time_passed * float_speed) * float_amplitude
	
	# Apply the position
	position.y = _initial_y + y_offset
	
func _on_body_entered(body):
	if body is CharacterBody2D:
		MaskManager.collect_mask(mask_type)
		queue_free()
