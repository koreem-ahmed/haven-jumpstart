extends Area2D


func _on_body_entered(body: Node2D) -> void:
	call_deferred("change")

func change():
	get_tree().reload_current_scene()
