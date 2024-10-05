extends Control

@onready var loading_screen: PackedScene = preload("res://scenes/ui/loading_screen.tscn")
@onready var button_hover: AudioStreamPlayer = $Sounds/ButtonHover

func _on_play_pressed() -> void:
	Global.scene_to_load("res://scenes/world.tscn")
	get_tree().change_scene_to_packed(loading_screen)

func _on_settings_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_button_mouse_entered() -> void:
	button_hover.play()
