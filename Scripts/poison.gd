extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and MaskManager.current_mask != MaskManager.MaskType.FOG:
		get_tree().quit()

func _process(_delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body is CharacterBody2D and MaskManager.current_mask != MaskManager.MaskType.FOG:
			get_tree().quit()
