@tool
class_name ControlList
extends PanelContainer

signal slot_clicked( _index : int, _object : Variant )


@onready var item_controls = $Container/Items
@onready var bar = $Container/ScrollBar


@export var item_pattern : PackedScene = null :
	set( _new_pattern ):
		if item_controls != null:
			for _child in item_controls.get_children():
				_child.queue_free()
		
		if _new_pattern != null:
			var _test_instance : PanelContainer = _new_pattern.instantiate()
			if not "gui_input" in _test_instance:
				print( "Unable to find gui_input signal in item pattern %s" % _new_pattern )
				return
			if not "object" in _test_instance:
				print( "Unable to find object member in item pattern %s" % _new_pattern )
				return
			_test_instance.queue_free()
		
		item_pattern = _new_pattern
		
		if item_pattern == null:
			return
		
		if item_controls != null:
			for _i in page:
				var _new_slot : PanelContainer = item_pattern.instantiate()
				_new_slot.connect( "gui_input", _slot_gui_input.bind(_new_slot) )
				item_controls.add_child( _new_slot )


@export var item_list : SignaledArray = null :
	set( _new_list ):
		if item_list != null:
			if item_list.is_connected( "signaled_array_changed", _on_signaled_array_changed ):
				item_list.disconnect( "signaled_array_changed", _on_signaled_array_changed )
		
		item_list = _new_list
		
		if _new_list != null:
			if not _new_list.is_connected( "signaled_array_changed", _on_signaled_array_changed ):
				_new_list.connect( "signaled_array_changed", _on_signaled_array_changed )
			
			if bar != null:
				if _new_list.size() > page:
					bar.min_value = 0
					bar.max_value = _new_list.size()
					bar.page = page
					bar.show()
				else:
					bar.hide()
		else:
			if bar != null:
				bar.value = 0
				bar.hide()
		
		build_list()


@export_range(1, 1024) var page : int = 1:
	set( _new_count ):
		if item_controls != null:
			if item_pattern != null:
				var _count : int = page
				if page > _new_count:
					var _slots : Array = item_controls.get_children()
					for _i in page - _new_count:
						page -= 1
						_slots[page].queue_free()
				else:
					for _i in _new_count - page:
						var _new_slot = item_pattern.instantiate()
						_new_slot.connect( "gui_input", _slot_gui_input.bind(_new_slot) )
						item_controls.add_child( _new_slot )
		
		page = _new_count


func build_list( _bar_value : float = 0 ):
	if item_list == null:
		return
	
	if bar != null:
		if item_list.size() > page:
			bar.min_value = 0
			bar.max_value = item_list.size()
			bar.page = page
			bar.show()
			if not bar.is_connected( "value_changed", build_list ):
				bar.connect( "value_changed", build_list )
		else:
			bar.hide()
			if bar.is_connected( "value_changed", build_list ):
				bar.disconnect( "value_changed", build_list )
		
		var _index : int = 0
		for _child in item_controls.get_children():
			if bar.value + _index >= item_list.size():
				_child.hide()
			else:
				_child.object = item_list.get_at( bar.value + _index )
				_child.show()
			_index += 1


func _gui_input( _event ):
	if _event is InputEventMouseButton:
		if _event.pressed:
			match _event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					if bar.value < item_list.size() - page:
						bar.value += 1
				
				MOUSE_BUTTON_WHEEL_UP:
					if bar.value > 0:
						bar.value -= 1


func _slot_gui_input( _event, _slot : Variant ):
	if _event is InputEventMouseButton:
		match  _event.button_index:
			MOUSE_BUTTON_LEFT:
				if _event.pressed:
					var _index : int = item_controls.get_children().find( _slot )
					emit_signal( "slot_clicked", _index + bar.value )


func _ready():
	bar.hide()
	
	if item_pattern != null:
		for _i in page:
			var _slot = item_pattern.instantiate()
			_slot.connect( "gui_input", _slot_gui_input.bind(_slot) )
			item_controls.add_child( _slot )
			if not Engine.is_editor_hint():
				_slot.hide()



func _on_signaled_array_changed( _item : Variant ):
	if _item == null:
		build_list()
	else:
		if item_list != null:
			var _index : int = 0
			for _child in item_controls.get_children():
				if bar.value + _index < item_list.size():
					if _child.object == _item:
						_child.object = _item # reassigning the object makes it update
				else:
					break
				_index += 1


func get_scroll_value() -> int:
	if bar != null:
		return bar.value
	else:
		return 0
