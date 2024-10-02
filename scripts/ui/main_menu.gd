class_name MainMenu

extends Control

@onready var play: Button = $Margin/HorizontalBox/VerticalBox/Play as Button
@onready var settings: Button = $Margin/HorizontalBox/VerticalBox/Settings as Button
@onready var exit: Button = $Margin/HorizontalBox/VerticalBox/Exit as Button
@onready var world = preload("res://scenes/world.tscn")
@onready var settings_menu = preload("res://scenes/settings_menu.tscn")

func _ready():
	play.button_down.connect(on_play_pressed)
	settings.button_down.connect(on_settings_pressed)
	exit.button_down.connect(on_exit_pressed)

func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(world)
	pass

func on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(settings_menu)
	pass

func on_exit_pressed() -> void:
	get_tree().quit()
