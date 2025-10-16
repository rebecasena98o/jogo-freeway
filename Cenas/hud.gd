extends CanvasLayer

@onready var timer = $Timer
signal reinicia
signal acaboutempo


func _on_button_pressed() -> void:
	emit_signal("reinicia")



func time_left_to_live():
	var time_left = $"../TimerGame".time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	

func _process(delta):
	$Timerlabel.text = "%02d:%02d" % time_left_to_live()
