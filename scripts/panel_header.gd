@tool
class_name PanelHeader
extends Panel


signal exit_queue
signal changed


@onready var title_label : Label = $HBoxContainer/Title
@onready var exit_button : Button = $HBoxContainer/ExitButton


@export var title : String = "":
	set( _new_title ):
		if not is_node_ready():
			await ready
		
		title = _new_title
		title_label.text = _new_title
		emit_signal( "changed" )


@export_flags( "Close Button:1" ) var flags : int = 1 :
	set( _new_flags ):
		if not is_node_ready():
			await ready
		
		flags = _new_flags
		if exit_button != null:
			if flags & 1:
				exit_button.show()
			else:
				exit_button.hide()
