class_name SignaledArray
extends Resource


signal signaled_array_changed( _item : Variant )

var array : Array = []


func _on_item_changed( _item : Variant ):
	emit_signal( "signaled_array_changed", _item )


func set_at( _index : int, _item : Variant ):
	if array[_index] == _item:
		return
	
	var _old_item = array[_index]
	if _old_item != null:
		if _item.is_connected( "changed", _on_item_changed ):
			_old_item.disconnect( "changed", _on_item_changed )
	
	array[_index] = _item
	
	if _item != null:
		if not _item.is_connected( "changed", _on_item_changed ):
			_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func get_at( _index : int ) -> Variant:
	return array[_index]


func append( _item : Variant ):
	array.append( _item )
	
	if _item != null:
		if not _item.is_connected( "changed", _on_item_changed ):
			_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func append_array( _new_array : Array ):
	array.append_array( _new_array )
	
	for _i in _new_array.size():
		var _item = _new_array[_i]
		if _item != null:
			if not _item.is_connected( "changed", _on_item_changed ):
				_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func assign( _new_array : Array ):
	for _i in array.size():
		var _old_item = array[_i]
		if _old_item != null:
			if _old_item.is_connected( "changed", _on_item_changed ):
				_old_item.disconnect( "changed", _on_item_changed )
	
	array.assign( _new_array )
	
	for _i in array.size():
		var _item = array[_i]
		if _item != null:
			if not _item.is_connected( "changed", _on_item_changed ):
				_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func clear():
	for _i in array.size():
		var _item = array[_i]
		if _item != null:
			if _item.is_connected( "changed", _on_item_changed ):
				_item.disconnect( "changed", _on_item_changed )
	
	array.clear()
	
	emit_signal( "signaled_array_changed", null )


func erase( _item : Variant ):
	for _i in array.size():
		var _old_item = array[_i]
		if _old_item == _item:
			if _old_item.is_connected( "changed", _on_item_changed ):
				_old_item.disconnect( "changed", _on_item_changed )
			break
	
	array.erase( _item )
	
	emit_signal( "signaled_array_changed", null )


func fill( _item : Variant ):
	for _i in array.size():
		var _old_item = array[_i]
		if _old_item != null:
			if _old_item.is_connected( "changed", _on_item_changed ):
				_old_item.disconnect( "changed", _on_item_changed )
	
	array.fill( _item )
	
	if _item != null:
		if not _item.is_connected( "changed", _on_item_changed ):
			_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func insert( _index : int, _item : Variant ) -> int:
	var _res : int = array.insert( _index, _item )
	if _res == OK:
		if _item != null:
			if not _item.is_connected( "changed", _on_item_changed ):
				_item.connect( "changed", _on_item_changed.bind( _item ) )
		
		emit_signal( "signaled_array_changed", null )
	
	return _res


func pop_at( _index : int ) -> Variant:
	var _item : Variant = array.pop_at( _index )
	
	if _item != null:
		if _item.is_connected( "changed", _on_item_changed ):
			_item.disconnect( "changed", _on_item_changed )
	
	emit_signal( "signaled_array_changed", null )
	
	return _item


func pop_back() -> Variant:
	var _item : Variant = array.pop_back()
	if _item != null:
		if _item.is_connected( "changed", _on_item_changed ):
			_item.disconnect( "changed", _on_item_changed )
	
	emit_signal( "signaled_array_changed", null )
	
	return _item


func pop_front() -> Variant:
	var _item : Variant = array.pop_front()
	
	if _item != null:
		if _item.is_connected( "changed", _on_item_changed ):
			_item.disconnect( "changed", _on_item_changed )
	
	emit_signal( "signaled_array_changed", null )
	
	return _item


func push_back( _item : Variant ):
	append( _item )


func push_front( _item : Variant ):
	array.push_front( _item )
	
	if _item != null:
		if not _item.is_connected( "changed", _on_item_changed ):
			_item.connect( "changed", _on_item_changed.bind( _item ) )
	
	emit_signal( "signaled_array_changed", null )


func remove_at( _index : int ):
	var _item = array[_index]
	if _item != null:
		if _item.is_connected( "changed", _on_item_changed ):
			_item.disconnect( "changed", _on_item_changed )
	
	array.remove_at( _index )
	
	emit_signal( "signaled_array_changed", null )


func resize( _size : int ):
	if _size < array.size():
		for _i in range( _size, array.size() ):
			var _item = array[_i]
			if _item != null:
				if _item.is_connected( "changed", _on_item_changed ):
					_item.disconnect( "changed", _on_item_changed )
	
	array.resize( _size )
	
	emit_signal( "signaled_array_changed", null )


func reverse():
	array.reverse()
	
	emit_signal( "signaled_array_changed", null )


func shuffle():
	array.shuffle()
	
	emit_signal( "signaled_array_changed", null )


func sort():
	array.sort()
	
	emit_signal( "signaled_array_changed", null )


func sort_custom( _callable : Callable ):
	array.sort_custom( _callable )
	
	emit_signal( "signaled_array_changed", null )


func size() -> int:
	return array.size()


func connect_item_signal():
	for _i in array.size():
		var _item = array[_i]
		if _item != null:
			if not _item.is_connected( "changed", _on_item_changed ):
				_item.connect( "changed", _on_item_changed.bind( _item ) )
