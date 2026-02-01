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
		# Reset fog density
		material.set_shader_parameter("density", 0.0)
		breathe_fog()

func breathe_fog():
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/density", GlobalSettings.MAX_FOG_DENSITY, duration)
