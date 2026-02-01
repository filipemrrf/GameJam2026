extends Node2D

# This creates a dropdown in the Godot Inspector
@export var active_mask: MaskManager.MaskType

func _ready():
	MaskManager.mask_changed.connect(_on_mask_changed)
	_update_state(MaskManager.current_mask)

func _on_mask_changed(new_mask: MaskManager.MaskType):
	_update_state(new_mask)

func _update_state(new_mask):
	# Simple visibility check
	visible = !(new_mask == active_mask)
	$".".collision_enabled = !(new_mask == active_mask)
