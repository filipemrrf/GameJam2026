extends Node

enum MaskType { DEFAULT, FOG, DRUNK }

signal mask_changed(new_mask)

var current_mask: MaskType = MaskType.DEFAULT
var owned_masks: Array[MaskType] = [MaskType.DEFAULT]

func change_mask(type: MaskType):
	current_mask = type
	mask_changed.emit(current_mask) # Notify all listeners

func _input(event):
	if event.is_action_pressed("RotateMaskRight"):
		cycle_mask_right()
	if event.is_action_pressed("RotateMaskLeft"):
		cycle_mask_left()

func cycle_mask_right():
	var current_index = owned_masks.find(current_mask)
	
	# Calculate the next index (looping back to 0 at the end)
	var next_index = (current_index + 1) % owned_masks.size()
	change_mask(owned_masks[next_index])
	
func cycle_mask_left():
	var current_index = owned_masks.find(current_mask)
	
	# Calculate the next index (looping back to 0 at the end)
	var next_index = (current_index - 1) % owned_masks.size()
	change_mask(owned_masks[next_index])

func collect_mask(type: MaskType):
	owned_masks.append(type)
	change_mask(type)
