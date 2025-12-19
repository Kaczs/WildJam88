extends RigidBody2D


func _on_sprite_2d_texture_changed() -> void:
	print(str($Sprite2D.texture))
