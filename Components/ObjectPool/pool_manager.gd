extends Node

@export var pool_array: Array[PoolResource]

var pool_dictionary: Dictionary[int, Array]


func create_pool(object_scene: PackedScene, pool_size: int) -> void:
	var parent_node: Node2D = Node2D.new()
	get_tree().current_scene.add_child(parent_node)
	
	var pool_key: int = object_scene.get_instance_id()
	if not pool_dictionary.has(pool_key):
		pool_dictionary[pool_key] = []
		
		for i in range(pool_size):
			var object: Node2D = object_scene.instantiate()
			parent_node.add_child(object)
			object.visible = false
			pool_dictionary[pool_key].append(object)


func get_object(object_scene: PackedScene) -> Node2D:
	return null
