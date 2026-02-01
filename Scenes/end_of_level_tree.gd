extends Area2D

@export_file("*.tscn") var next_scene_path: String

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.pee()
		
		await get_tree().create_timer(2.5).timeout
		
		if next_scene_path == "":
			return
		
		# Change to the new level
		MaskManager.owned_masks.clear()
		MaskManager.collect_mask(MaskManager.MaskType.DEFAULT)
		get_tree().change_scene_to_file(next_scene_path)
