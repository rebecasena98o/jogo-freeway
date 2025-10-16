class_name DateTime extends Resource 

@export var seconds = 0
@export var minutes = 0

@export_range(0,5) var default_minutes := 2 
@export_range(0,59) var default_seconds := 0

func _ready() -> void:
	Timer_counter.text = str("%02d" % default_minutes)
