extends Area2D
@export var next_scene:String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SoundManager.next_track(true)
		get_tree().change_scene_to_file(next_scene)
		#Progress to next
