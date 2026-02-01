extends ColorRect

@export var mask_type: MaskManager.MaskType
@export var duration: float

var current_tween: Tween

func _ready():
	MaskManager.mask_changed.connect(_on_mask_changed)

func _on_mask_changed(new_mask: MaskManager.MaskType):
	_activate_mask_view(new_mask)

func _activate_mask_view(new_mask):
	if visible and (new_mask != mask_type):
		current_tween = create_tween()
		current_tween.tween_property(material, "shader_parameter/drunk_intensity", 0, duration / 2)
	
	visible = (new_mask == mask_type)
	
	if visible:
		drunken()

func drunken():
	current_tween = create_tween()
	current_tween.tween_property(material, "shader_parameter/drunk_intensity", GlobalSettings.MAX_DRUNK_INTENSITY, duration)
