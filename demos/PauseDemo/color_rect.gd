extends ColorRect

var x_dir = 1 + randi_range(1,2)
var y_dir = 1 + randi_range(1,2)
func _process(_delta: float) -> void:
	position.x += x_dir
	position.y += y_dir
	
	if position.x >= 200: x_dir = -(1 + randi_range(1,2))
	if position.x <= -200: x_dir = (1 + randi_range(1,2))
	if position.y >= 200: y_dir = -(1 + randi_range(1,2))
	if position.y <= -200: y_dir = (1 + randi_range(1,2))
