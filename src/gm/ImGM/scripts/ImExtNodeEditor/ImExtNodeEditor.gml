function ImExtNodeEditor() constructor {
    #region Binds

    /**
	 * @function AcceptCopy
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts a copy action during a shortcut interaction.
	 *
	 * @return {Bool}
	 */
	static AcceptCopy = function() {
		return __imext_node_editor_accept_copy();
	}

	/**
	 * @function AcceptCreateNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts a create-node action during a shortcut interaction.
	 *
	 * @return {Bool}
	 */
	static AcceptCreateNode = function() {
		return __imext_node_editor_accept_create_node();
	}

	/**
	 * @function AcceptCut
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts a cut action during a shortcut interaction.
	 *
	 * @return {Bool}
	 */
	static AcceptCut = function() {
		return __imext_node_editor_accept_cut();
	}

	/**
	 * @function AcceptDeletedItem
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts the current deleted item operation.
	 *
	 * @param {Bool} delete_dependencies Whether linked dependencies should also be removed.
	 * @return {Bool}
	 */
	static AcceptDeletedItem = function(delete_dependencies) {
		return __imext_node_editor_accept_deleted_item(delete_dependencies);
	}

	/**
	 * @function AcceptDuplicate
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts a duplicate action during a shortcut interaction.
	 *
	 * @return {Bool}
	 */
	static AcceptDuplicate = function() {
		return __imext_node_editor_accept_duplicate();
	}

	/**
	 * @function AcceptNewItem
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts the current new item operation.
	 *
	 * @return {Bool}
	 */
	static AcceptNewItem = function() {
		return __imext_node_editor_accept_new_item();
	}

	/**
	 * @function AcceptNewItemWithStyle
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Accepts the current new item operation with custom style.
	 *
	 * @param {Real} color
	 * @param {Real} alpha
	 * @param {Real} thickness
	 * @return {Bool}
	 */
	static AcceptNewItemWithStyle = function(color, alpha, thickness) {
		return __imext_node_editor_accept_new_item_with_style(color, alpha, thickness);
	}

	/**
	 * @function AcceptPaste
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Accepts a paste action during a shortcut interaction.
	 *
	 * @return {Bool}
	 */
	static AcceptPaste = function() {
		return __imext_node_editor_accept_paste();
	}

	/**
	 * @function AreShortcutsEnabled
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether shortcuts are currently enabled.
	 *
	 * @return {Bool}
	 */
	static AreShortcutsEnabled = function() {
		return __imext_node_editor_are_shortcuts_enabled();
	}

	/**
	 * @function Begin
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a new NodeEditor frame.
	 *
	 * @param {String} _id The editor identifier.
	 * @param {Real} width The editor width.
	 * @param {Real} height The editor height.
	 * @return {Undefined}
	 */
	static Begin = function(_id, width, height) {
		return __imext_node_editor_begin(_id, width, height);
	}

	/**
	 * @function BeginCreate
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins creation of a new item.
	 *
	 * @param {Any} [color=undefined] A GameMaker color value.
	 * @param {Real} [alpha=1] The alpha component.
	 * @param {Real} [thickness=1] The item thickness.
	 * @return {undefined}
	 */
	static BeginCreate = function(color=undefined, alpha=1, thickness=1) {
		return __imext_node_editor_begin_create(color, alpha, thickness);
	}

	/**
	 * @function BeginDelete
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a delete operation.
	 *
	 * @return {Bool}
	 */
	static BeginDelete = function() {
		return __imext_node_editor_begin_delete();
	}

	/**
	 * @function BeginGroupHint
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a group hint for a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Bool}
	 */
	static BeginGroupHint = function(node_id) {
		return __imext_node_editor_begin_group_hint(node_id);
	}

	/**
	 * @function BeginNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a node block.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Undefined}
	 */
	static BeginNode = function(node_id) {
		return __imext_node_editor_begin_node(node_id);
	}

	/**
	 * @function BeginPin
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a pin block.
	 *
	 * @param {Any} pin_id The pin identifier.
	 * @param {Real} kind The pin kind (input or output).
	 * @return {Undefined}
	 */
	static BeginPin = function(pin_id, kind) {
		return __imext_node_editor_begin_pin(pin_id, kind);
	}

	/**
	 * @function BeginShortcut
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Begins a shortcut interaction block.
	 *
	 * @return {Bool}
	 */
	static BeginShortcut = function() {
		return __imext_node_editor_begin_shortcut();
	}

	/**
	 * @function BreakLinksNode
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Breaks all links connected to a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static BreakLinksNode = function(node_id) {
		return __imext_node_editor_break_links_node(node_id);
	}

	/**
	 * @function BreakLinksPin
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Breaks all links connected to a pin.
	 *
	 * @param {Any} pin_id The pin identifier.
	 * @return {Real}
	 */
	static BreakLinksPin = function(pin_id) {
		return __imext_node_editor_break_links_pin(pin_id);
	}

	/**
	 * @function CanvasToScreenX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Converts a canvas-space X position to screen-space.
	 *
	 * @param {Real} _x The X coordinate.
	 * @param {Real} _y The Y coordinate.
	 * @return {Real}
	 */
	static CanvasToScreenX = function(_x, _y) {
		return __imext_node_editor_canvas_to_screen_x(_x, _y);
	}

	/**
	 * @function CanvasToScreenY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Converts a canvas-space Y position to screen-space.
	 *
	 * @param {Real} _x The X coordinate.
	 * @param {Real} _y The Y coordinate.
	 * @return {Real}
	 */
	static CanvasToScreenY = function(_x, _y) {
		return __imext_node_editor_canvas_to_screen_y(_x, _y);
	}

	/**
	 * @function CenterNodeOnScreen
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Centers a node on screen.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Undefined}
	 */
	static CenterNodeOnScreen = function(node_id) {
		return __imext_node_editor_center_node_on_screen(node_id);
	}

	/**
	 * @function ClearSelection
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Clears the current selection.
	 *
	 * @return {Undefined}
	 */
	static ClearSelection = function() {
		return __imext_node_editor_clear_selection();
	}

	/**
	 * @function CreateEditor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Creates a new NodeEditor context.
	 *
	 * @return {Pointer}
	 */
	static CreateEditor = function() {
		return __imext_node_editor_create_editor();
	}

	/**
	 * @function DeleteLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Deletes a link.
	 *
	 * @param {Any} link_id The link identifier.
	 * @return {Bool}
	 */
	static DeleteLink = function(link_id) {
		return __imext_node_editor_delete_link(link_id);
	}

	/**
	 * @function DeleteNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Deletes a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Bool}
	 */
	static DeleteNode = function(node_id) {
		return __imext_node_editor_delete_node(node_id);
	}

	/**
	 * @function DeselectLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Deselects a link.
	 *
	 * @param {Any} link_id The link identifier.
	 * @return {Undefined}
	 */
	static DeselectLink = function(link_id) {
		return __imext_node_editor_deselect_link(link_id);
	}

	/**
	 * @function DeselectNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Deselects a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Undefined}
	 */
	static DeselectNode = function(node_id) {
		return __imext_node_editor_deselect_node(node_id);
	}

	/**
	 * @function DestroyEditor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Destroys a NodeEditor context.
	 *
	 * @param {Any} [editor=undefined] Pointer to the editor context created by CreateEditor.
	 * @return {Undefined}
	 */
	static DestroyEditor = function(editor=undefined) {
		return __imext_node_editor_destroy_editor(editor);
	}

	/**
	 * @function EnableShortcuts
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Enables or disables editor shortcuts.
	 *
	 * @param {Bool} enable Whether shortcuts should be enabled.
	 * @return {Undefined}
	 */
	static EnableShortcuts = function(enable) {
		return __imext_node_editor_enable_shortcuts(enable);
	}

	/**
	 * @function End
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends the current NodeEditor frame.
	 *
	 * @return {Undefined}
	 */
	static End = function() {
		return __imext_node_editor_end();
	}

	/**
	 * @function EndCreate
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends the current item creation operation.
	 *
	 * @return {Undefined}
	 */
	static EndCreate = function() {
		return __imext_node_editor_end_create();
	}

	/**
	 * @function EndDelete
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends the current delete operation.
	 *
	 * @return {Undefined}
	 */
	static EndDelete = function() {
		return __imext_node_editor_end_delete();
	}

	/**
	 * @function EndGroupHint
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * TODO: Add a way to manage node background channels
	 *
	 * Ends the current group hint.
	 *
	 * @return {Undefined}
	 */
	static EndGroupHint = function() {
		return __imext_node_editor_end_group_hint();
	}

	/**
	 * @function EndNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends a node block.
	 *
	 * @return {Undefined}
	 */
	static EndNode = function() {
		return __imext_node_editor_end_node();
	}

	/**
	 * @function EndPin
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends a pin block.
	 *
	 * @return {Undefined}
	 */
	static EndPin = function() {
		return __imext_node_editor_end_pin();
	}

	/**
	 * @function EndShortcut
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Ends a shortcut interaction block.
	 *
	 * @return {Undefined}
	 */
	static EndShortcut = function() {
		return __imext_node_editor_end_shortcut();
	}

	/**
	 * @function Flow
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Flows a link in a specific direction.
	 *
	 * @param {Any} link_id The link identifier.
	 * @param {Real} direction The flow direction.
	 * @return {Undefined}
	 */
	static Flow = function(link_id, direction) {
		return __imext_node_editor_flow(link_id, direction);
	}

	/**
	 * @function GetActionContextLinks
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the link ids in the current action context.
	 *
	 * @return {Real}
	 */
	static GetActionContextLinks = function() {
		return __imext_node_editor_get_action_context_links();
	}

	/**
	 * @function GetActionContextNodes
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the node ids in the current action context.
	 *
	 * @return {Real}
	 */
	static GetActionContextNodes = function() {
		return __imext_node_editor_get_action_context_nodes();
	}

	/**
	 * @function GetActionContextSize
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the size of the current action context.
	 *
	 * @return {Real}
	 */
	static GetActionContextSize = function() {
		return __imext_node_editor_get_action_context_size();
	}

	/**
	 * @function GetBackgroundClickButtonIndex
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * -1 if none
	 *
	 * Returns the button index used for a background click.
	 *
	 * @return {Real}
	 */
	static GetBackgroundClickButtonIndex = function() {
		return __imext_node_editor_get_background_click_button_index();
	}

	/**
	 * @function GetBackgroundDoubleClickButtonIndex
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * -1 if none
	 *
	 * Returns the button index used for a background double-click.
	 *
	 * @return {Real}
	 */
	static GetBackgroundDoubleClickButtonIndex = function() {
		return __imext_node_editor_get_background_double_click_button_index();
	}

	/**
	 * @function GetConfig
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the current editor configuration.
	 *
	 * @return {Undefined}
	 */
	static GetConfig = function() {
		return __imext_node_editor_get_config();
	}

	/**
	 * @function GetCurrentEditor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the current editor context pointer.
	 *
	 * @return {Pointer}
	 */
	static GetCurrentEditor = function() {
		return __imext_node_editor_get_current_editor();
	}

	/**
	 * @function GetCurrentZoom
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the current zoom level.
	 *
	 * @return {Real}
	 */
	static GetCurrentZoom = function() {
		return __imext_node_editor_get_current_zoom();
	}

	/**
	 * @function GetDoubleClickedLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the link that was double-clicked.
	 *
	 * @return {Pointer}
	 */
	static GetDoubleClickedLink = function() {
		return __imext_node_editor_get_double_clicked_link();
	}

	/**
	 * @function GetDoubleClickedNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the node that was double-clicked.
	 *
	 * @return {Pointer}
	 */
	static GetDoubleClickedNode = function() {
		return __imext_node_editor_get_double_clicked_node();
	}

	/**
	 * @function GetDoubleClickedPin
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the pin that was double-clicked.
	 *
	 * @return {Pointer}
	 */
	static GetDoubleClickedPin = function() {
		return __imext_node_editor_get_double_clicked_pin();
	}

	/**
	 * @function GetGroupMaxX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the maximum X group hint bounds.
	 *
	 * @return {Real}
	 */
	static GetGroupMaxX = function() {
		return __imext_node_editor_get_group_max_x();
	}

	/**
	 * @function GetGroupMaxY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the maximum Y group hint bounds.
	 *
	 * @return {Real}
	 */
	static GetGroupMaxY = function() {
		return __imext_node_editor_get_group_max_y();
	}

	/**
	 * @function GetGroupMinX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the minimum X group hint bounds.
	 *
	 * @return {Real}
	 */
	static GetGroupMinX = function() {
		return __imext_node_editor_get_group_min_x();
	}

	/**
	 * @function GetGroupMinY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the minimum Y group hint bounds.
	 *
	 * @return {Real}
	 */
	static GetGroupMinY = function() {
		return __imext_node_editor_get_group_min_y();
	}

	/**
	 * @function GetHintBackgroundDrawList
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the background draw list for the current group hint.
	 *
	 * @return {Pointer}
	 */
	static GetHintBackgroundDrawList = function() {
		return __imext_node_editor_get_hint_background_draw_list();
	}

	/**
	 * @function GetHintForegroundDrawList
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the foreground draw list for the current group hint.
	 *
	 * @return {Pointer}
	 */
	static GetHintForegroundDrawList = function() {
		return __imext_node_editor_get_hint_foreground_draw_list();
	}

	/**
	 * @function GetHoveredLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the link currently hovered by the mouse.
	 *
	 * @return {Pointer}
	 */
	static GetHoveredLink = function() {
		return __imext_node_editor_get_hovered_link();
	}

	/**
	 * @function GetHoveredNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the node currently hovered by the mouse.
	 *
	 * @return {Pointer}
	 */
	static GetHoveredNode = function() {
		return __imext_node_editor_get_hovered_node();
	}

	/**
	 * @function GetHoveredPin
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the pin currently hovered by the mouse.
	 *
	 * @return {Pointer}
	 */
	static GetHoveredPin = function() {
		return __imext_node_editor_get_hovered_pin();
	}

	/**
	 * @function GetLinkPins
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * pass nullptr if particular pin do not interest you
	 *
	 * Returns the start and end pins for a link.
	 *
	 * @param {Any} link_id The link identifier.
	 * @return {Bool}
	 */
	static GetLinkPins = function(link_id) {
		return __imext_node_editor_get_link_pins(link_id);
	}

	/**
	 * @function GetNodeBackgroundDrawList
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the node background draw list for a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Pointer}
	 */
	static GetNodeBackgroundDrawList = function(node_id) {
		return __imext_node_editor_get_node_background_draw_list(node_id);
	}

	/**
	 * @function GetNodeCount
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns number of submitted nodes since Begin() call
	 *
	 * Returns the number of submitted nodes since the current Begin call.
	 *
	 * @return {Real}
	 */
	static GetNodeCount = function() {
		return __imext_node_editor_get_node_count();
	}

	/**
	 * @function GetNodePositionX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the X position of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static GetNodePositionX = function(node_id) {
		return __imext_node_editor_get_node_position_x(node_id);
	}

	/**
	 * @function GetNodePositionY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the Y position of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static GetNodePositionY = function(node_id) {
		return __imext_node_editor_get_node_position_y(node_id);
	}

	/**
	 * @function GetNodeSizeX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the width of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static GetNodeSizeX = function(node_id) {
		return __imext_node_editor_get_node_size_x(node_id);
	}

	/**
	 * @function GetNodeSizeY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the height of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static GetNodeSizeY = function(node_id) {
		return __imext_node_editor_get_node_size_y(node_id);
	}

	/**
	 * @function GetNodeZPosition
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns node z position, defaults is 0.0f
	 *
	 * Returns the z-position of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Real}
	 */
	static GetNodeZPosition = function(node_id) {
		return __imext_node_editor_get_node_z_position(node_id);
	}

	/**
	 * @function GetOrderedNodeIds
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Fills an array with node id's in order they're drawn; up to 'size` elements are set. Returns actual size of filled id's.
	 *
	 * Returns a list of ordered node IDs for the current frame.
	 *
	 * @return {Real}
	 */
	static GetOrderedNodeIds = function() {
		return __imext_node_editor_get_ordered_node_ids();
	}

	/**
	 * @function GetScreenSizeX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the screen width of the editor canvas.
	 *
	 * @return {Real}
	 */
	static GetScreenSizeX = function() {
		return __imext_node_editor_get_screen_size_x();
	}

	/**
	 * @function GetScreenSizeY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the screen height of the editor canvas.
	 *
	 * @return {Real}
	 */
	static GetScreenSizeY = function() {
		return __imext_node_editor_get_screen_size_y();
	}

	/**
	 * @function GetSelectedLinks
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the number of selected links.
	 *
	 * @return {Real}
	 */
	static GetSelectedLinks = function() {
		return __imext_node_editor_get_selected_links();
	}

	/**
	 * @function GetSelectedNodes
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the number of selected nodes.
	 *
	 * @return {Real}
	 */
	static GetSelectedNodes = function() {
		return __imext_node_editor_get_selected_nodes();
	}

	/**
	 * @function GetSelectedObjectCount
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the number of selected objects.
	 *
	 * @return {Real}
	 */
	static GetSelectedObjectCount = function() {
		return __imext_node_editor_get_selected_object_count();
	}

	/**
	 * @function GetStyle
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns the editor style object.
	 *
	 * @return {Undefined}
	 */
	static GetStyle = function() {
		return __imext_node_editor_get_style();
	}

	/**
	 * @function GetStyleColorName
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns the human-readable name for a style color.
	 *
	 * @param {Real} color_index The style color index.
	 * @return {String}
	 */
	static GetStyleColorName = function(color_index) {
		return __imext_node_editor_get_style_color_name(color_index);
	}

	/**
	 * @function Group
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Draws a group rectangle.
	 *
	 * @param {Real} width The group width.
	 * @param {Real} height The group height.
	 * @return {Undefined}
	 */
	static Group = function(width, height) {
		return __imext_node_editor_group(width, height);
	}

	/**
	 * @function HasAnyLinksNode
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns whether a node has any links.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Bool}
	 */
	static HasAnyLinksNode = function(node_id) {
		return __imext_node_editor_has_any_links_node(node_id);
	}

	/**
	 * @function HasAnyLinksPin
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Returns whether a pin has any links.
	 *
	 * @param {Any} pin_id The pin identifier.
	 * @return {Bool}
	 */
	static HasAnyLinksPin = function(pin_id) {
		return __imext_node_editor_has_any_links_pin(pin_id);
	}

	/**
	 * @function HasSelectionChanged
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether the selection state changed this frame.
	 *
	 * @return {Bool}
	 */
	static HasSelectionChanged = function() {
		return __imext_node_editor_has_selection_changed();
	}

	/**
	 * @function IsActive
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether the editor is active.
	 *
	 * @return {Bool}
	 */
	static IsActive = function() {
		return __imext_node_editor_is_active();
	}

	/**
	 * @function IsBackgroundClicked
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether the background was clicked.
	 *
	 * @return {Bool}
	 */
	static IsBackgroundClicked = function() {
		return __imext_node_editor_is_background_clicked();
	}

	/**
	 * @function IsBackgroundDoubleClicked
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether the background was double-clicked.
	 *
	 * @return {Bool}
	 */
	static IsBackgroundDoubleClicked = function() {
		return __imext_node_editor_is_background_double_clicked();
	}

	/**
	 * @function IsLinkSelected
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether a link is selected.
	 *
	 * @param {Any} link_id The link identifier.
	 * @return {Bool}
	 */
	static IsLinkSelected = function(link_id) {
		return __imext_node_editor_is_link_selected(link_id);
	}

	/**
	 * @function IsNodeSelected
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether a node is selected.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Bool}
	 */
	static IsNodeSelected = function(node_id) {
		return __imext_node_editor_is_node_selected(node_id);
	}

	/**
	 * @function IsSuspended
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether the editor is currently suspended.
	 *
	 * @return {Bool}
	 */
	static IsSuspended = function() {
		return __imext_node_editor_is_suspended();
	}

	/**
	 * @function Link
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Creates a link between two pins.
	 *
	 * @param {Any} link_id The link identifier.
	 * @param {Any} start_pin_id The source pin identifier.
	 * @param {Any} end_pin_id The target pin identifier.
	 * @param {Real} [col=c_white]
	 * @param {Real} [alpha=1] The alpha component.
	 * @param {Real} [thickness=1] The link thickness.
	 * @return {Bool}
	 */
	static Link = function(link_id, start_pin_id, end_pin_id, col=c_white, alpha=1, thickness=1) {
		return __imext_node_editor_link(link_id, start_pin_id, end_pin_id, col, alpha, thickness);
	}

	/**
	 * @function NavigateToContent
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Navigates the editor view to its content.
	 *
	 * @param {Real} duration The navigation duration in seconds.
	 * @return {Undefined}
	 */
	static NavigateToContent = function(duration) {
		return __imext_node_editor_navigate_to_content(duration);
	}

	/**
	 * @function NavigateToSelection
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Navigates the editor view to the current selection.
	 *
	 * @param {Bool} zoom_in Whether to zoom in.
	 * @param {Real} duration The navigation duration in seconds.
	 * @return {Undefined}
	 */
	static NavigateToSelection = function(zoom_in, duration) {
		return __imext_node_editor_navigate_to_selection(zoom_in, duration);
	}

	/**
	 * @function PinHadAnyLinks
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Returns whether a pin had any links.
	 *
	 * @param {Any} pin_id The pin identifier.
	 * @return {Bool}
	 */
	static PinHadAnyLinks = function(pin_id) {
		return __imext_node_editor_pin_had_any_links(pin_id);
	}

	/**
	 * @function PinPivotAlignment
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets the pin pivot alignment.
	 *
	 * @param {Real} _x The X alignment.
	 * @param {Real} _y The Y alignment.
	 * @return {Undefined}
	 */
	static PinPivotAlignment = function(_x, _y) {
		return __imext_node_editor_pin_pivot_alignment(_x, _y);
	}

	/**
	 * @function PinPivotRect
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Draws a pivot rectangle for a pin.
	 *
	 * @param {Real} x1 The first X coordinate.
	 * @param {Real} y1 The first Y coordinate.
	 * @param {Real} x2 The second X coordinate.
	 * @param {Real} y2 The second Y coordinate.
	 * @return {Undefined}
	 */
	static PinPivotRect = function(x1, y1, x2, y2) {
		return __imext_node_editor_pin_pivot_rect(x1, y1, x2, y2);
	}

	/**
	 * @function PinPivotScale
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets the pin pivot scale.
	 *
	 * @param {Real} _x The X scale.
	 * @param {Real} _y The Y scale.
	 * @return {Undefined}
	 */
	static PinPivotScale = function(_x, _y) {
		return __imext_node_editor_pin_pivot_scale(_x, _y);
	}

	/**
	 * @function PinPivotSize
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets the pin pivot size.
	 *
	 * @param {Real} width The width.
	 * @param {Real} height The height.
	 * @return {Undefined}
	 */
	static PinPivotSize = function(width, height) {
		return __imext_node_editor_pin_pivot_size(width, height);
	}

	/**
	 * @function PinRect
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Draws a pin rectangle.
	 *
	 * @param {Real} x1 The first X coordinate.
	 * @param {Real} y1 The first Y coordinate.
	 * @param {Real} x2 The second X coordinate.
	 * @param {Real} y2 The second Y coordinate.
	 * @return {Undefined}
	 */
	static PinRect = function(x1, y1, x2, y2) {
		return __imext_node_editor_pin_rect(x1, y1, x2, y2);
	}

	/**
	 * @function PopStyleColor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Pops one or more style color entries from the current editor style stack.
	 *
	 * @param {Real} count The number of entries to pop.
	 * @return {Undefined}
	 */
	static PopStyleColor = function(count) {
		return __imext_node_editor_pop_style_color(count);
	}

	/**
	 * @function PopStyleVar
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Pops one or more style variables from the current editor style stack.
	 *
	 * @param {Real} count The number of entries to pop.
	 * @return {Undefined}
	 */
	static PopStyleVar = function(count) {
		return __imext_node_editor_pop_style_var(count);
	}

	/**
	 * @function PushStyleColor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Pushes a color override onto the current editor style stack.
	 *
	 * @param {Real} color_index The style color index.
	 * @param {Real} col
	 * @param {Real} alpha The alpha component.
	 * @return {Undefined}
	 */
	static PushStyleColor = function(color_index, col, alpha) {
		return __imext_node_editor_push_style_color(color_index, col, alpha);
	}

	/**
	 * @function PushStyleVar
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Pushes a style variable value onto the current editor style stack.
	 *
	 * @param {Real} var_index The style variable index.
	 * @param {Real} value The value to push.
	 * @return {Undefined}
	 */
	static PushStyleVar = function(var_index, value) {
		return __imext_node_editor_push_style_var(var_index, value);
	}

	/**
	 * @function PushStyleVarVec2
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Pushes a 2D style variable value onto the current editor style stack.
	 *
	 * @param {Real} var_index The style variable index.
	 * @param {Real} _x The X component.
	 * @param {Real} _y The Y component.
	 * @return {Undefined}
	 */
	static PushStyleVarVec2 = function(var_index, _x, _y) {
		return __imext_node_editor_push_style_var_vec2(var_index, _x, _y);
	}

	/**
	 * @function PushStyleVarVec4
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Pushes a 4D style variable value onto the current editor style stack.
	 *
	 * @param {Real} var_index The style variable index.
	 * @param {Real} _x The X component.
	 * @param {Real} _y The Y component.
	 * @param {Real} z The Z component.
	 * @param {Real} w The W component.
	 * @return {Undefined}
	 */
	static PushStyleVarVec4 = function(var_index, _x, _y, z, w) {
		return __imext_node_editor_push_style_var_vec4(var_index, _x, _y, z, w);
	}

	/**
	 * @function QueryDeletedLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Queries a deleted link item.
	 *
	 * @param {Any} [result_obj=undefined] An object of { success, link_id, start_pin_id, end_pin_id } that will be updated.
	 * @return {Bool}
	 */
	static QueryDeletedLink = function(result_obj=undefined) {
		result_obj ??= {success:false, link_id:-1, start_pin_id:-1, end_pin_id:-1};
		return __imext_node_editor_query_deleted_link(result_obj);
	}

	/**
	 * @function QueryDeletedNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Queries a deleted node item.
	 *
	 * @return {Int64}
	 */
	static QueryDeletedNode = function() {
		return __imext_node_editor_query_deleted_node();
	}

	/**
	 * @function QueryNewLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Queries a new link creation operation.
	 *
	 * @param {Any} [result_obj=undefined] An object of { success, start_pin_id, end_pin_id } that would be updated.
	 * @return {Bool}
	 */
	static QueryNewLink = function(result_obj=undefined) {
		result_obj ??= {success:false, start_pin_id:undefined, end_pin_id:undefined};
		return __imext_node_editor_query_new_link(result_obj);
	}

	/**
	 * @function QueryNewLinkWithStyle
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Queries a new link creation operation with custom style.
	 *
	 * @param {Any} [result_obj=undefined] An object of { success, start_pin_id, end_pin_id } that will be updated.
	 * @param {Real} color A GameMaker color value.
	 * @param {Real} alpha The alpha component.
	 * @param {Real} thickness The link thickness.
	 * @return {Bool}
	 */
	static QueryNewLinkWithStyle = function(result_obj=undefined, color, alpha, thickness) {
		result_obj ??= {success:false, start_pin_id:undefined, end_pin_id:undefined};
		return __imext_node_editor_query_new_link_with_style(result_obj, color, alpha, thickness);
	}

	/**
	 * @function QueryNewNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Queries a new node creation operation.
	 *
	 * @return {PinId|Int64}
	 */
	static QueryNewNode = function() {
		return __imext_node_editor_query_new_node();
	}

	/**
	 * @function QueryNewNodeWithStyle
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Queries a new node creation operation with custom style.
	 *
	 * @param {Real} color A GameMaker color value.
	 * @param {Real} alpha The alpha component.
	 * @param {Real} thickness
	 * @return {PinId|Int64}
	 */
	static QueryNewNodeWithStyle = function(color, alpha, thickness) {
		return __imext_node_editor_query_new_node_with_style(color, alpha, thickness);
	}

	/**
	 * @function RejectDeletedItem
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Rejects the current deleted item operation.
	 *
	 * @return {Undefined}
	 */
	static RejectDeletedItem = function() {
		return __imext_node_editor_reject_deleted_item();
	}

	/**
	 * @function RejectNewItem
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Rejects the current new item operation.
	 *
	 * @return {Undefined}
	 */
	static RejectNewItem = function() {
		return __imext_node_editor_reject_new_item();
	}

	/**
	 * @function RejectNewItemWithStyle
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Rejects the current new item operation with custom style.
	 *
	 * @param {Real} color
	 * @param {Real} alpha
	 * @param {Real} thickness
	 * @return {Undefined}
	 */
	static RejectNewItemWithStyle = function(color, alpha, thickness) {
		return __imext_node_editor_reject_new_item_with_style(color, alpha, thickness);
	}

	/**
	 * @function RestoreNodeState
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Restores the saved state of a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @return {Undefined}
	 */
	static RestoreNodeState = function(node_id) {
		return __imext_node_editor_restore_node_state(node_id);
	}

	/**
	 * @function Resume
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Resumes the editor interaction flow.
	 *
	 * @return {Undefined}
	 */
	static Resume = function() {
		return __imext_node_editor_resume();
	}

	/**
	 * @function ScreenToCanvasX
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Converts a screen-space X position to canvas-space.
	 *
	 * @param {Real} _x The X coordinate.
	 * @param {Real} _y The Y coordinate.
	 * @return {Real}
	 */
	static ScreenToCanvasX = function(_x, _y) {
		return __imext_node_editor_screen_to_canvas_x(_x, _y);
	}

	/**
	 * @function ScreenToCanvasY
	 * @context NodeEditor
	 * @desc ImGM custom wrapper for `NodeEditor`.
	 * Converts a screen-space Y position to canvas-space.
	 *
	 * @param {Real} _x The X coordinate.
	 * @param {Real} _y The Y coordinate.
	 * @return {Real}
	 */
	static ScreenToCanvasY = function(_x, _y) {
		return __imext_node_editor_screen_to_canvas_y(_x, _y);
	}

	/**
	 * @function SelectLink
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Selects a link.
	 *
	 * @param {Any} link_id The link identifier.
	 * @param {Bool} append Whether to append to the current selection.
	 * @return {Undefined}
	 */
	static SelectLink = function(link_id, append) {
		return __imext_node_editor_select_link(link_id, append);
	}

	/**
	 * @function SelectNode
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Selects a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @param {Bool} append Whether to append to the current selection.
	 * @return {Undefined}
	 */
	static SelectNode = function(node_id, append) {
		return __imext_node_editor_select_node(node_id, append);
	}

	/**
	 * @function SetCurrentEditor
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets the current editor context.
	 *
	 * @param {Any} [editor=undefined] Pointer to the editor context.
	 * @return {Undefined}
	 */
	static SetCurrentEditor = function(editor=undefined) {
		return __imext_node_editor_set_current_editor(editor);
	}

	/**
	 * @function SetGroupSize
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets a node group size in editor space.
	 *
	 * @param {Any} node_id The node identifier.
	 * @param {Real} width The width.
	 * @param {Real} height The height.
	 * @return {Undefined}
	 */
	static SetGroupSize = function(node_id, width, height) {
		return __imext_node_editor_set_group_size(node_id, width, height);
	}

	/**
	 * @function SetNodePosition
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets a node position in editor space.
	 *
	 * @param {Any} node_id The node identifier.
	 * @param {Real} _x The X position.
	 * @param {Real} _y The Y position.
	 * @return {Undefined}
	 */
	static SetNodePosition = function(node_id, _x, _y) {
		return __imext_node_editor_set_node_position(node_id, _x, _y);
	}

	/**
	 * @function SetNodeZPosition
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Sets node z position, nodes with higher value are drawn over nodes with lower value
	 *
	 * Sets the z-position for a node.
	 *
	 * @param {Any} node_id The node identifier.
	 * @param {Real} z The z-position.
	 * @return {Undefined}
	 */
	static SetNodeZPosition = function(node_id, z) {
		return __imext_node_editor_set_node_z_position(node_id, z);
	}

	/**
	 * @function ShowBackgroundContextMenu
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Shows the background context menu.
	 *
	 * @return {Bool}
	 */
	static ShowBackgroundContextMenu = function() {
		return __imext_node_editor_show_background_context_menu();
	}

	/**
	 * @function ShowLinkContextMenu
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Shows the link context menu and returns whether a link was selected.
	 *
	 * @return {Bool}
	 */
	static ShowLinkContextMenu = function() {
		return __imext_node_editor_show_link_context_menu();
	}

	/**
	 * @function ShowNodeContextMenu
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Shows the node context menu and returns whether a node was selected.
	 *
	 * @return {Bool}
	 */
	static ShowNodeContextMenu = function() {
		return __imext_node_editor_show_node_context_menu();
	}

	/**
	 * @function ShowPinContextMenu
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Shows the pin context menu and returns whether a pin was selected.
	 *
	 * @return {Bool}
	 */
	static ShowPinContextMenu = function() {
		return __imext_node_editor_show_pin_context_menu();
	}

	/**
	 * @function Suspend
	 * @context NodeEditor
	 * @desc ImGM wrapper for `NodeEditor`.
	 * Suspends the editor interaction flow.
	 *
	 * @return {Undefined}
	 */
	static Suspend = function() {
		return __imext_node_editor_suspend();
	}

    #endregion

    #region Enums

    /**
	 * @enum ImExtNodeEditorPinKind
	 *
	 */
	enum ImExtNodeEditorPinKind {
		Input,
		Output,
	}

	/**
	 * @enum ImExtNodeEditorFlowDirection
	 *
	 */
	enum ImExtNodeEditorFlowDirection {
		Forward,
		Backward,
	}

	/**
	 * @enum ImExtNodeEditorCanvasSizeMode
	 *
	 */
	enum ImExtNodeEditorCanvasSizeMode {
		FitVerticalView,
		FitHorizontalView,
		CenterOnly,
	}

	/**
	 * @enum ImExtNodeEditorSaveReasonFlags
	 *
	 */
	enum ImExtNodeEditorSaveReasonFlags {
		None = 0x00000000,
		Navigation = 0x00000001,
		Position = 0x00000002,
		Size = 0x00000004,
		Selection = 0x00000008,
		AddNode = 0x00000010,
		RemoveNode = 0x00000020,
		User = 0x00000040,
	}

	/**
	 * @enum ImExtNodeEditorStyleColor
	 *
	 */
	enum ImExtNodeEditorStyleColor {
		Bg,
		Grid,
		NodeBg,
		NodeBorder,
		HovNodeBorder,
		SelNodeBorder,
		NodeSelRect,
		NodeSelRectBorder,
		HovLinkBorder,
		SelLinkBorder,
		HighlightLinkBorder,
		LinkSelRect,
		LinkSelRectBorder,
		PinRect,
		PinRectBorder,
		Flow,
		FlowMarker,
		GroupBg,
		GroupBorder,
	}

	/**
	 * @enum ImExtNodeEditorStyleVar
	 *
	 */
	enum ImExtNodeEditorStyleVar {
		NodePadding,
		NodeRounding,
		NodeBorderWidth,
		HoveredNodeBorderWidth,
		SelectedNodeBorderWidth,
		PinRounding,
		PinBorderWidth,
		LinkStrength,
		SourceDirection,
		TargetDirection,
		ScrollDuration,
		FlowMarkerDistance,
		FlowSpeed,
		FlowDuration,
		PivotAlignment,
		PivotSize,
		PivotScale,
		PinCorners,
		PinRadius,
		PinArrowSize,
		PinArrowWidth,
		GroupRounding,
		GroupBorderWidth,
		HighlightConnectedLinks,
		SnapLinkToPinDir,
		HoveredNodeBorderOffset,
		SelectedNodeBorderOffset,
	}

    #endregion

    #region Internal
    static __initialized = false;

    static Initialize = function() {
        ImExtNodeEditor.__initialized = true;
    }

    static __NewFrame = function(state=undefined) {
    }

    /// autocalls
	__ImGui_Initialize = method(self, function(state) {
		return Initialize();
	})

    __ImGui_NewFrame = method(self, function(state) {
        return __NewFrame(state); // self
    })

    #endregion
}
