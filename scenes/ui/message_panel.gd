extends Control
class_name MessagePanel

signal message_done

@onready var label: Label = $TextureRect/MessageLabel
@onready var indicator: Control = $TextureRect/ContinueIndicator

var typing_speed := 0.03  # Seconds per character
var is_typing := false

func _ready():
	hide()
	indicator.hide()

func show_message(text: String):
	label.text = ""
	indicator.hide()
	show()
	is_typing = true

	await _type_text(text)
	is_typing = false

	indicator.show()
	await _wait_for_input()
	hide()
	indicator.hide()
	emit_signal("message_done")

func _type_text(text: String) -> void:
	for i in text.length():
		label.text += text[i]
		await get_tree().create_timer(typing_speed).timeout

func _wait_for_input() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"):
			break
