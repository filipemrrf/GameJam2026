extends ColorRect

@export var mask_type: MaskManager.MaskType
@export var duration: float

func _ready():
	MaskManager.mask_changed.connect(_on_mask_changed)

func _on_mask_changed(new_mask: MaskManager.MaskType):
	_activate_mask_view(new_mask)

func _activate_mask_view(new_mask):
	visible = (new_mask == mask_type)
	
	if visible:
		# Reset drunk intensity
		material.set_shader_parameter("drunk_intensity", 0.0)
		drunken()

func drunken():
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/drunk_intensity", GlobalSettings.MAX_DRUNK_INTENSITY, duration)
