@tool
class_name ControlListItem
extends PanelContainer

@onready var item_icon : TextureRect = $Container/Icon
@onready var item_name : Label = $Container/Name
@onready var item_button : Button = $Container/Button
@onready var item_selected : Panel = $Selected


var base_node : Variant = null


@export var object : Variant = null:
	set( _new_object ):
		object = _new_object
		
		if object == null:
			hide()
			return
		
		if object.icon != null:
			item_icon.texture = object.icon
			item_icon.show()
		else:
			item_icon.hide()
		
		item_name.text = object.name
		
		show()


func _on_button_clicked():
	if base_node != null:
		base_node.emit_signal( "edit_object_name", object )
	
	#var _main_loop : SceneTree = Engine.get_main_loop()
	#if _main_loop != null:
		#if _main_loop.current_scene != null:
			#_main_loop.current_scene.emit_signal( "edit_object_name", object )


func _on_mouse_entered():
	item_selected.show()


func _on_mouse_exited():
	item_selected.hide()


func _on_tree_entered():
	if not Engine.is_editor_hint():
		base_node = null
		var _scene_tree : SceneTree = get_tree()
		if _scene_tree != null:
			var _root = _scene_tree.get_root()
			if _root != null:
				base_node = _root.get_node( "Main" )


func _on_tree_exited():
	base_node = null
