class_name SettingsMenu

extends Control

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
