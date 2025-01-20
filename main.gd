class_name MainScript
extends CanvasLayer

signal edit_object_name( _object : Variant )

@onready var control_list : ControlList = $TestPanel/ControlList

var text_edit_scene : PackedScene = preload( "res://scenes/text_edit_panel.tscn" )

var list : SignaledArray = null


func _ready():
	list = SignaledArray.new()
	control_list.item_list = list
	
	for _i in 32:
		var _object := ListedObject.new( "Object %03d" % _i )
		list.append( _object )
		list.append( _object )


func _on_edit_object_name( _object : Variant ):
	var _text_edit_panel = text_edit_scene.instantiate()
	if _text_edit_panel != null:
		_text_edit_panel.object = _object
		add_child( _text_edit_panel )
	else:
		printerr( "_on_edit_object_name: Unable to instantiate text edit panel")


func _on_control_list_slot_clicked( _index : int ):
	var _object = list.get_at( _index )
	print( "index %d: %s item clicked" % [ _index, _object.name ] )


func _on_panel_header_exit_queue():
	print( "Panel exit queue" )
