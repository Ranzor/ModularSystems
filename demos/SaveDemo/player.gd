extends Node2D
var save_data : Dictionary = {
	"player_health": { "node": self, "property": "health"}
}
@export var health = 255

func _ready() -> void:
	health = SaveLite.load_value("player", "health", 420)
	SaveLite.save_value("player", "health", health)
