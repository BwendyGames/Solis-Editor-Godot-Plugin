@tool
extends EditorPlugin

var solis_path_setting := "solis_editor_plugin/solis_path"
var inspector_plugin = null

# ----------- Inspector Plugin -----------
class SolisInspectorPlugin:
	extends EditorInspectorPlugin
	var main_plugin: EditorPlugin

	func _init(main_plugin_ref: EditorPlugin):
		main_plugin = main_plugin_ref

	func _can_handle(object):
		return object is GDScript

	func _parse_begin(object):
		var button = Button.new()
		button.text = "Open with Solis Text Editor"
		button.pressed.connect(func(): _on_open_with_solis_pressed(object))
		add_custom_control(button)

	func _on_open_with_solis_pressed(script_obj):
		var script_path = script_obj.resource_path
		var abs_path = ProjectSettings.globalize_path(script_path)
		var editor_settings = main_plugin.get_editor_interface().get_editor_settings()
		var solis_path = editor_settings.get(main_plugin.solis_path_setting)
		if not solis_path or not FileAccess.file_exists(solis_path):
			main_plugin.show_warning("Solis editor path not set. Please set it in Tools → Set Solis Editor Path...", "Solis Text Editor")
			return
		print("Launching:", solis_path, abs_path)
		var result = OS.execute(solis_path, [abs_path])
		if result != OK:
			main_plugin.show_warning("Failed to launch Solis Editor.", "Solis Text Editor")

# ----------- Main Plugin -----------
func _enter_tree():
	add_tool_menu_item("Open with Solis Text Editor", Callable(self, "_on_open_with_solis"))
	add_tool_menu_item("Set Solis Editor Path...", Callable(self, "_on_set_solis_path"))

	inspector_plugin = SolisInspectorPlugin.new(self)
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_tool_menu_item("Open with Solis Text Editor")
	remove_tool_menu_item("Set Solis Editor Path...")
	if inspector_plugin:
		remove_inspector_plugin(inspector_plugin)
		inspector_plugin = null

func _on_open_with_solis():
	var editor_interface = get_editor_interface()
	var script = editor_interface.get_script_editor().get_current_script()
	if not script:
		show_warning("No script file is currently open.", "Solis Text Editor")
		return
	var script_path = script.resource_path
	var abs_path = ProjectSettings.globalize_path(script_path)
	var editor_settings = get_editor_interface().get_editor_settings()
	var solis_path = editor_settings.get(solis_path_setting)
	if not solis_path or not FileAccess.file_exists(solis_path):
		show_warning("Solis editor path not set. Please set it in Tools -> Set Solis Editor Path...", "Solis Text Editor")
		return
	print("Launching:", solis_path, abs_path)
	var result = OS.execute(solis_path, [abs_path])
	if result != OK:
		show_warning("Failed to launch Solis Editor.", "Solis Text Editor")

func _on_set_solis_path():
	var file_dialog := FileDialog.new()
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.title = "Select Solis Text Editor Executable"
	file_dialog.filters = PackedStringArray(["*.exe ; Solis Editor Executable"])
	file_dialog.file_selected.connect(_on_solis_path_selected)
	get_tree().root.add_child(file_dialog)
	file_dialog.popup_centered()

func _on_solis_path_selected(path):
	var editor_settings = get_editor_interface().get_editor_settings()
	editor_settings.set(solis_path_setting, path)
	call_deferred("show_notice", "Solis Text Editor path saved:\n" + path, "Solis Text Editor")

func show_notice(msg, title="Notice"):
	var popup := AcceptDialog.new()
	popup.dialog_text = msg
	popup.title = title
	get_tree().root.add_child(popup)
	popup.popup_centered()

func show_warning(msg, title="Warning"):
	var popup := AcceptDialog.new()
	popup.dialog_text = msg
	popup.title = title
	get_tree().root.add_child(popup)
	popup.popup_centered()
