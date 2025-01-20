class_name TextEditPanel
extends ColorRect

@onready var header : Panel = $Panel/PanelHeader
@onready var line_edit : LineEdit = $Panel/LineEdit


var object : Variant = null :
	set( _new_object ):
		if object == _new_object:
			return
		if _new_object == null:
			printerr( "TextEditPanel object can't be null" )
			return
		if not "name" in _new_object:
			printerr( "TextEditPanel object has no name" )
			return
		
		object = _new_object
		


func _ready():
	if object != null:
		line_edit.text = object.name
		line_edit.caret_column = object.name.length()
	else:
		line_edit.text = ""
		line_edit.caret_column = 0
	
	header.connect( "exit_queue", queue_free )
	line_edit.text_submitted.connect( _on_text_submitted )
	line_edit.focus_exited.connect( queue_free )
	line_edit.grab_focus()


func _on_text_submitted( _new_text : String ):
	if object != null:
		object.name = _new_text
	
	queue_free()


func _gui_input( _event ):
	if _event is InputEventMouseButton:
		if _event.pressed:
			match _event.button_index:
				MOUSE_BUTTON_LEFT:
					queue_free()
