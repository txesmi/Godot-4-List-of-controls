class_name ListedObject
extends Object

# Every object must have a signal called changed 
# to be propery updated into the control list
signal changed

@export var name : String = "":
	set( _new_name ):
		if name == _new_name:
			return
		
		name = _new_name
		
		emit_signal( "changed" )


@export var icon : Texture2D = null:
	set( _new_icon ):
		if icon == _new_icon:
			return
		
		icon = _new_icon
		
		emit_signal( "changed" )


func _init( _name : String ):
	if randi() % 2 == 0:
		icon = null
	else:
		icon = load( "res://art/icon.png" )
	
	name = _name
