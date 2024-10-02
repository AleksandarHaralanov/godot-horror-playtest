class_name MainMenu

extends Control

@onready var play: Button = $Margin/HorizontalBox/VerticalBox/Play as Button
@onready var options: Button = $Margin/HorizontalBox/VerticalBox/Options as Button
@onready var exit: Button = $Margin/HorizontalBox/VerticalBox/Exit as Button
@onready var world = preload("res://scenes/world.tscn")

func _ready():
	play.button_down.connect(on_play_pressed)
	options.button_down.connect(on_options_pressed)
	exit.button_down.connect(on_exit_pressed)

func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(world)
	pass

func on_options_pressed() -> void:
	pass

func on_exit_pressed() -> void:
	get_tree().quit()
