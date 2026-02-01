extends ColorRect

@export var mask_type: MaskManager.MaskType
@export var duration: float

var current_tween: Tween

func _ready():
	MaskManager.mask_changed.connect(_on_mask_changed)

func _on_mask_changed(new_mask: MaskManager.MaskType):
	_activate_mask_view(new_mask)

func _activate_mask_view(new_mask):
	visible = (new_mask == mask_type)
	
	if visible:
		# Reset fog density
		if current_tween:
			current_tween.kill()
			
		material.set_shader_parameter("density", 0.0)
		breathe_fog()

func breathe_fog():
	current_tween = create_tween()
	current_tween.tween_property(material, "shader_parameter/density", GlobalSettings.MAX_FOG_DENSITY, duration)
