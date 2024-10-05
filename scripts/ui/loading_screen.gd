extends Control

var loading_progress: Array = []
var loading_status: int = 0

@onready var scene_to_load: String = Global.scene_being_loaded
@onready var loading_text: Label = $Progress

func _ready() -> void:
	ResourceLoader.load_threaded_request(scene_to_load)

func _process(_delta: float) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(scene_to_load, loading_progress)
	loading_text.text = str(floor(loading_progress[0] * 100)) + "%"
	if loading_status is ResourceLoader.ThreadLoadStatus:
		var loaded_scene: PackedScene = ResourceLoader.load_threaded_get(scene_to_load)
		get_tree().change_scene_to_packed(loaded_scene)
