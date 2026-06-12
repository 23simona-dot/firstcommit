extends Control

const save_path = "user://userdata.save"

var energy = 0
var amount_per_click = 1

signal energy_changed

func _ready() -> void:
	load_data()
	emit_signal("energy_changed", energy)

func save_data():
	var data = {
		"energy": energy,
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ) 
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			energy = data.get("energy", 0)
	else:
		save_data()
	
func _on_texture_button_button_down() -> void:
	energy += amount_per_click
	emit_signal("energy_changed", energy)
	save_data()

