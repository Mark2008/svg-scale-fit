@tool
extends EditorPlugin

var inspector_plugin: EditorInspectorPlugin \
	= preload("res://addons/svg-scale-fit/inspector_plugin.gd").new()

#func _enable_plugin(): start()
func _enter_tree(): start()

func start():
	#print('[svg-auto-scale] Hello!!')
	
	add_inspector_plugin(inspector_plugin)
	

func _disable_plugin() -> void:
	#print('[svg-auto-scale] Bye!!')
	
	remove_inspector_plugin(inspector_plugin)
