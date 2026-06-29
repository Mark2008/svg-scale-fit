@tool
extends EditorInspectorPlugin

var scale_icon := preload("res://addons/svg-scale-fit/scale_button.svg")

func _can_handle(object):
	return object is Sprite2D

func _parse_begin(object):
	var button := Button.new()
	button.text = "Apply SVG Scale"
	button.icon = scale_icon
	button.pressed.connect(func():
		apply_svg_scale(object as Sprite2D)
	)
	add_custom_control(button)

func apply_svg_scale(sprite_2d: Sprite2D):
	var tex := sprite_2d.texture
	if not tex:
		push_error("There's no texture to apply scale")
		return

	var path: String
	if tex is CompressedTexture2D:
		path = tex.resource_path + ".import"
	elif tex is AtlasTexture:
		path = tex.atlas.resource_path + ".import"
	else:
		push_error("Unimplemented texture type")
		
	# read `.import` file
	var cfg := ConfigFile.new()
	var err := cfg.load(path)
	if err != OK:
		push_error("Error while reading config file: `", path, "`, error: ", err)
		return
	
	var scale := cfg.get_value("params", "svg/scale", 1.0) as float
	
	# real apply
	sprite_2d.scale = Vector2.ONE / scale
	
	#for section in cfg.get_sections():
		#print("[", section, "]")
		#for key in cfg.get_section_keys(section):
			#print(key, " = ", cfg.get_value(section, key))
