# Godot 4 List of Controls  
A scrollable list of a custom single control pattern that is automatically updated when the defining array or its contents change.

A test bench created for learning purposes. Don't take it too seriously. You've been warned.

### scripts/listed_object.gd  
A simple object ready to be listed.  
It emits a *changed* signal when modified.

### scripts/signaled_array.gd  
An abstraction of the Array structure *sloppily* encapsulated in a class so it can receive and emit signals.  
It listens for objects' *changed* signals and emits a *signaled_array_changed* signal with the object as a parameter when an object changes.  
It also emits a *signaled_array_changed* signal with a null parameter when any array operation modifies the array itself.

### scenes/control_list.tscn  
The list manager. The core of this test bench.  
It is a @tool, so it shows the list in the editor.  
It requires a control-based packed scene to be instantiated to form the list and establish the connections.  
It also needs a SignaledArray to populate the list.  
It rebuilds the entire list when it receives the *signaled_array_changed* signal.  
It manages the visibility and size of the scroll bar.

### scenes/control_list_item.tscn  
A custom pattern to be instantiated to form the control list.  
It is a @tool, so it is shown in the editor.  
Theoretically, it can be of any kind. Its functionality must be defined based on its use.  
The only rule is that any pattern must rebuild itself when the *object* member changes.
