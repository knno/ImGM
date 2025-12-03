function ImGui() constructor {

    #region Extensions

    /// Manually-updated section for ImGui extensions.
    static Ext = {
        NodeEditor: new ImExtNodeEditor(),
    }
    #endregion

	#region Binds

	/**
	 * @function AcceptDragDropPayload
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * accept contents of a given type. If ImGuiDragDropFlags_AcceptBeforeDelivery is set you can peek into the payload before the mouse button is released.
	 *
	 * @param {String} type
	 * @param {Enum.ImGuiDragDropFlags} [flags=ImGuiDragDropFlags.None]
	 * @return {Any|Undefined}
	 */
	static AcceptDragDropPayload = function(type, flags=ImGuiDragDropFlags.None) {
		return __imgui_accept_drag_drop_payload(type, flags);
	}

	/**
	 * @function AddFontDefault
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Pointer|Undefined}
	 */
	static AddFontDefault = function() {
		return __imgui_add_font_default();
	}

	/**
	 * @function AddFontFromFileTTF
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 * Adds a font from a TTF file on disk.
	 *
	 * @param {String} file The path to the TTF file.
	 * @param {Real} size_pixels The font size in pixels.
	 * @param {ImFontConfig} [font_cfg=undefined]
	 * @param {Array<Real>} [glyph_ranges=undefined] An optional flat array of unicode pairs [start,end...] ending with an optional terminating-zero element.
	 * e.g. Some characters for Arabic: [$0600, $06FF, $0750, $077F, 0]
	 *
	 * @return {Pointer|Undefined}
	 */
	static AddFontFromFileTTF = function(file, size_pixels, font_cfg=undefined, glyph_ranges=undefined) {
		return __imgui_add_font_from_file_TTF(file, size_pixels, font_cfg, glyph_ranges, array_length(glyph_ranges));
	}

	/**
	 * @function AlignTextToFramePadding
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * vertically align upcoming text baseline to FramePadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item)
	 *
	 * @return {Undefined}
	 */
	static AlignTextToFramePadding = function() {
		return __imgui_align_text_to_frame_padding();
	}

	/**
	 * @function ArrowButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * square button with an arrow shape
	 *
	 * @param {String} str_id
	 * @param {Real} _dir
	 * @return {Bool}
	 */
	static ArrowButton = function(str_id, _dir) {
		return __imgui_arrow_button(str_id, _dir);
	}

	/**
	 * @function Begin
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} name
	 * @param {Bool} [open=undefined]
	 * @param {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
	 * @param {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
	 * @return {Real}
	 */
	static Begin = function(name, open=undefined, flags=ImGuiWindowFlags.None, mask=ImGuiReturnMask.Return) {
		return __imgui_begin(name, open, flags, mask);
	}

	/**
	 * @function BeginChild
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} str_id
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {Enum.ImGuiChildFlags} [child_flags=ImGuiChildFlags.None]
	 * @param {Enum.ImGuiWindowFlags} [window_flags=ImGuiWindowFlags.None]
	 * @return {Bool}
	 */
	static BeginChild = function(str_id, width=0, height=0, child_flags=ImGuiChildFlags.None, window_flags=ImGuiWindowFlags.None) {
		return __imgui_begin_child(str_id, width, height, child_flags, window_flags);
	}

	/**
	 * @function BeginChildFrame
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} _id
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
	 * @return {Bool}
	 */
	static BeginChildFrame = function(_id, width=0, height=0, flags=ImGuiWindowFlags.None) {
		return __imgui_begin_child_frame(_id, width, height, flags);
	}

	/**
	 * @function BeginCombo
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} preview
	 * @param {Real} flags
	 * @return {Bool}
	 */
	static BeginCombo = function(label, preview, flags) {
		return __imgui_begin_combo(label, preview, flags);
	}

	/**
	 * @function BeginDisabled
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Bool} [disabled=true]
	 * @return {Undefined}
	 */
	static BeginDisabled = function(disabled=true) {
		return __imgui_begin_disabled(disabled);
	}

	/**
	 * @function BeginDragDropSource
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call after submitting an item which may be dragged. when this return true, you can call SetDragDropPayload() + EndDragDropSource()
	 *
	 * @param {Enum.ImGuiDragDropFlags} [flags=ImGuiDragDropFlags.None]
	 * @return {Bool}
	 */
	static BeginDragDropSource = function(flags=ImGuiDragDropFlags.None) {
		return __imgui_begin_drag_drop_source(flags);
	}

	/**
	 * @function BeginDragDropTarget
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call after submitting an item that may receive a payload. If this returns true, you can call AcceptDragDropPayload() + EndDragDropTarget()
	 *
	 * @return {Bool}
	 */
	static BeginDragDropTarget = function() {
		return __imgui_begin_drag_drop_target();
	}

	/**
	 * @function BeginGroup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * lock horizontal starting position
	 *
	 * @return {Undefined}
	 */
	static BeginGroup = function() {
		return __imgui_begin_group();
	}

	/**
	 * @function BeginItemTooltip
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * begin/append a tooltip window if preceding item was hovered.
	 *
	 * @return {Bool}
	 */
	static BeginItemTooltip = function() {
		return __imgui_begin_item_tooltip();
	}

	/**
	 * @function BeginListBox
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * open a framed scrolling region
	 *
	 * @param {String} label
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @return {Bool}
	 */
	static BeginListBox = function(label, width=0, height=0) {
		return __imgui_begin_list_box(label, width, height);
	}

	/**
	 * @function BeginMainMenuBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create and append to a full screen menu-bar.
	 *
	 * @return {Bool}
	 */
	static BeginMainMenuBar = function() {
		return __imgui_begin_main_menu_bar();
	}

	/**
	 * @function BeginMenu
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create a sub-menu entry. only call EndMenu() if this returns true!
	 *
	 * @param {String} label
	 * @param {Bool} [enabled=true]
	 * @return {Bool}
	 */
	static BeginMenu = function(label, enabled=true) {
		return __imgui_begin_menu(label, enabled);
	}

	/**
	 * @function BeginMenuBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * append to menu-bar of current window (requires ImGuiWindowFlags_MenuBar flag set on parent window).
	 *
	 * @return {Bool}
	 */
	static BeginMenuBar = function() {
		return __imgui_begin_menu_bar();
	}

	/**
	 * @function BeginMultiSelect
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {ImGuiMultiSelectFlags} flags
	 * @param {Real} size
	 * @param {Real} items_count
	 * @return {ImGuiMultiSelectIO}
	 */
	static BeginMultiSelect = function(flags, size, items_count) {
		return __imgui_begin_multi_select(flags, size, items_count);
	}

	/**
	 * @function BeginPopup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return true if the popup is open, and you can start outputting to it.
	 *
	 * @param {String} str_id
	 * @param {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
	 * @return {Bool}
	 */
	static BeginPopup = function(str_id, flags=ImGuiWindowFlags.None) {
		return __imgui_begin_popup(str_id, flags);
	}

	/**
	 * @function BeginPopupContextItem
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * open+begin popup when clicked on last item. Use str_id==NULL to associate the popup to previous item. If you want to use that on a non-interactive item such as Text() you need to pass in an explicit ID here. read comments in .cpp!
	 *
	 * @param {String} [str_id=undefined]
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
	 * @return {Bool}
	 */
	static BeginPopupContextItem = function(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
		return __imgui_begin_popup_context_item(str_id, flags);
	}

	/**
	 * @function BeginPopupContextVoid
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * open+begin popup when clicked in void (where there are no windows).
	 *
	 * @param {String} [str_id=undefined]
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
	 * @return {Bool}
	 */
	static BeginPopupContextVoid = function(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
		return __imgui_begin_popup_context_void(str_id, flags);
	}

	/**
	 * @function BeginPopupContextWindow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * open+begin popup when clicked on current window.
	 *
	 * @param {String} [str_id=undefined]
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
	 * @return {Bool}
	 */
	static BeginPopupContextWindow = function(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
		return __imgui_begin_popup_context_window(str_id, flags);
	}

	/**
	 * @function BeginPopupModal
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return true if the modal is open, and you can start outputting to it.
	 *
	 * @param {String} name
	 * @param {Bool} [open=undefined]
	 * @param {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
	 * @param {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
	 * @return {Real}
	 */
	static BeginPopupModal = function(name, open=undefined, flags=ImGuiWindowFlags.None, mask=ImGuiReturnMask.Return) {
		return __imgui_begin_popup_modal(name, open, flags, mask);
	}

	/**
	 * @function BeginTabBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create and append into a TabBar
	 *
	 * @param {String} str_id
	 * @param {Enum.ImGuiTabBarFlags} [flags=ImGuiTabBarFlags.None]
	 * @return {Bool}
	 */
	static BeginTabBar = function(str_id, flags=ImGuiTabBarFlags.None) {
		return __imgui_begin_tab_bar(str_id, flags);
	}

	/**
	 * @function BeginTabItem
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create a Tab. Returns true if the Tab is selected.
	 *
	 * @param {String} label
	 * @param {Bool} [open=undefined]
	 * @param {Enum.ImGuiTabItemFlags} [flags=ImGuiTabItemFlags.None]
	 * @param {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
	 * @return {Real}
	 */
	static BeginTabItem = function(label, open=undefined, flags=ImGuiTabItemFlags.None, mask=ImGuiReturnMask.Return) {
		return __imgui_begin_tab_item(label, open, flags, mask);
	}

	/**
	 * @function BeginTable
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} str_id
	 * @param {Real} column
	 * @param {Enum.ImGuiTableFlags} [flags=ImGuiTableFlags.None]
	 * @param {Real} [outer_width=0]
	 * @param {Real} [outer_height=0]
	 * @param {Real} [inner_width=0]
	 * @return {Bool}
	 */
	static BeginTable = function(str_id, column, flags=ImGuiTableFlags.None, outer_width=0, outer_height=0, inner_width=0) {
		return __imgui_begin_table(str_id, column, flags, outer_width, outer_height, inner_width);
	}

	/**
	 * @function BeginTooltip
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * begin/append a tooltip window.
	 *
	 * @return {Undefined}
	 */
	static BeginTooltip = function() {
		return __imgui_begin_tooltip();
	}

	/**
	 * @function Bullet
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * draw a small circle + keep the cursor on the same line. advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses
	 *
	 * @return {Undefined}
	 */
	static Bullet = function() {
		return __imgui_bullet();
	}

	/**
	 * @function BulletText
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @return {Undefined}
	 */
	static BulletText = function(val) {
		return __imgui_bullet_text(val);
	}

	/**
	 * @function Button
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * button
	 *
	 * @param {String} label
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @return {Bool}
	 */
	static Button = function(label, width=0, height=0) {
		return __imgui_button(label, width, height);
	}

	/**
	 * @function CalcItemWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * width of item given pushed settings and current cursor position. NOT necessarily the width of last item unlike most 'Item' functions.
	 *
	 * @return {Real}
	 */
	static CalcItemWidth = function() {
		return __imgui_calc_item_width();
	}

	/**
	 * @function CalcTextHeight
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} text
	 * @param {Bool} [hide_text_after_double_hash=false]
	 * @param {Real} [wrap_width=-1]
	 * @return {Real}
	 */
	static CalcTextHeight = function(text, hide_text_after_double_hash=false, wrap_width=-1) {
		return __imgui_calc_text_height(text, hide_text_after_double_hash, wrap_width);
	}

	/**
	 * @function CalcTextWidth
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} text
	 * @param {Bool} [hide_text_after_double_hash=false]
	 * @param {Real} [wrap_width=-1]
	 * @return {Real}
	 */
	static CalcTextWidth = function(text, hide_text_after_double_hash=false, wrap_width=-1) {
		return __imgui_calc_text_width(text, hide_text_after_double_hash, wrap_width);
	}

	/**
	 * @function Checkbox
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Bool} checked
	 * @return {Bool}
	 */
	static Checkbox = function(label, checked) {
		return __imgui_checkbox(label, checked);
	}

	/**
	 * @function CheckboxFlags
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} flags
	 * @param {Real} flags_value
	 * @return {Real}
	 */
	static CheckboxFlags = function(label, flags, flags_value) {
		return __imgui_checkbox_flags(label, flags, flags_value);
	}

	/**
	 * @function ClearIniSettings
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static ClearIniSettings = function() {
		return __imgui_clear_ini_settings();
	}

	/**
	 * @function CloseCurrentPopup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * manually close the popup we have begin-ed into.
	 *
	 * @return {Undefined}
	 */
	static CloseCurrentPopup = function() {
		return __imgui_close_current_popup();
	}

	/**
	 * @function CollapsingHeader
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * if returning 'true' the header is open. doesn't indent nor push on ID stack. user doesn't have to call TreePop().
	 *
	 * @param {String} label
	 * @param {Bool} [_visible=undefined]
	 * @param {Enum.ImGuiTreeNodeFlags} [flags=ImGuiTreeNodeFlags.None]
	 * @param {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
	 * @return {Real}
	 */
	static CollapsingHeader = function(label, _visible=undefined, flags=ImGuiTreeNodeFlags.None, mask=ImGuiReturnMask.Return) {
		return __imgui_collapsing_header(label, _visible, flags, mask);
	}

	/**
	 * @function ColorButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * display a color square/button, hover for details, return true when pressed.
	 *
	 * @param {String} desc_id
	 * @param {Real} color
	 * @param {Real} [alpha=1]
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @return {Bool}
	 */
	static ColorButton = function(desc_id, color, alpha=1, flags=ImGuiColorEditFlags.None, width=0, height=0) {
		return __imgui_color_button(desc_id, color, alpha, flags, width, height);
	}

	/**
	 * @function ColorEdit3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} col
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @return {Real}
	 */
	static ColorEdit3 = function(label, col, flags=ImGuiColorEditFlags.None) {
		return __imgui_color_edit3(label, col, flags);
	}

	/**
	 * @function ColorEdit4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {ImColor} col
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @return {Bool}
	 */
	static ColorEdit4 = function(label, col, flags=ImGuiColorEditFlags.None) {
		return __imgui_color_edit4(label, col, flags);
	}

	/**
	 * @function ColorPicker3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} col
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @return {Real}
	 */
	static ColorPicker3 = function(label, col, flags=ImGuiColorEditFlags.None) {
		return __imgui_color_picker3(label, col, flags);
	}

	/**
	 * @function ColorPicker4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {ImColor} col
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @return {Bool}
	 */
	static ColorPicker4 = function(label, col, flags=ImGuiColorEditFlags.None) {
		return __imgui_color_picker4(label, col, flags);
	}

	/**
	 * @function Columns
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * LEGACY COLUMN API
	 *
	 * @param {Real} [count=1]
	 * @param {String} [_id=]
	 * @param {Bool} [border=true]
	 * @return {Undefined}
	 */
	static Columns = function(count=1, _id="", border=true) {
		return __imgui_columns(count, _id, border);
	}

	/**
	 * @function Combo
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {undefined}
	 */
	static Combo = function() {
		return __imgui_combo();
	}

	/**
	 * @function ConfigFlagsGet
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static ConfigFlagsGet = function() {
		return __imgui_config_flags_get();
	}

	/**
	 * @function ConfigFlagsSet
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} flags
	 * @return {undefined}
	 */
	static ConfigFlagsSet = function(flags) {
		return __imgui_config_flags_set(flags);
	}

	/**
	 * @function ConfigFlagToggle
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} flag
	 * @return {Bool}
	 */
	static ConfigFlagToggle = function(flag) {
		return __imgui_config_flag_toggle(flag);
	}

	/**
	 * @function CreateContext
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Pointer}
	 */
	static CreateContext = function() {
		return __imgui_create_context();
	}

	/**
	 * @function CreateMultiSelectBasicStorage
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Struct} yystruct
	 * @return {Pointer}
	 */
	static CreateMultiSelectBasicStorage = function(yystruct) {
		return __imgui_create_multi_select_basic_storage(yystruct);
	}

	/**
	 * @function DestroyContext
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * NULL = destroy current context
	 *
	 * @param {Pointer} ctx
	 * @return {Undefined}
	 */
	static DestroyContext = function(ctx) {
		return __imgui_destroy_context(ctx);
	}

	/**
	 * @function DestroyMultiSelectBasicStorage
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} storage_ptr
	 * @return {Undefined}
	 */
	static DestroyMultiSelectBasicStorage = function(storage_ptr) {
		return __imgui_destroy_multi_select_basic_storage(storage_ptr);
	}

	/**
	 * @function DockBuilderAddNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} [node_id=0]
	 * @param {Enum.ImGuiDockNodeFlags} [flags=ImGuiDockNodeFlags.None]
	 * @return {Real}
	 */
	static DockBuilderAddNode = function(node_id=0, flags=ImGuiDockNodeFlags.None) {
		return __imgui_dock_builder_add_node(node_id, flags);
	}

	/**
	 * @function DockBuilderCopyDockSpace
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} src_dockspace_id
	 * @param {Real} dst_dockspace_id
	 * @param {Any} window_remap_pairs
	 * @return {Undefined}
	 */
	static DockBuilderCopyDockSpace = function(src_dockspace_id, dst_dockspace_id, window_remap_pairs) {
		return __imgui_dock_builder_copy_dock_space(src_dockspace_id, dst_dockspace_id, window_remap_pairs);
	}

	/**
	 * @function DockBuilderCopyNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} src_node_id
	 * @param {Real} dst_node_id
	 * @param {Any} node_remap_pairs
	 * @return {undefined}
	 */
	static DockBuilderCopyNode = function(src_node_id, dst_node_id, node_remap_pairs) {
		return __imgui_dock_builder_copy_node(src_node_id, dst_node_id, node_remap_pairs);
	}

	/**
	 * @function DockBuilderCopyWindowSettings
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} src_name
	 * @param {String} dst_name
	 * @return {Undefined}
	 */
	static DockBuilderCopyWindowSettings = function(src_name, dst_name) {
		return __imgui_dock_builder_copy_window_settings(src_name, dst_name);
	}

	/**
	 * @function DockBuilderDockWindow
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} window_name
	 * @param {Real} node_id
	 * @return {Undefined}
	 */
	static DockBuilderDockWindow = function(window_name, node_id) {
		return __imgui_dock_builder_dock_window(window_name, node_id);
	}

	/**
	 * @function DockBuilderFinish
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @return {Undefined}
	 */
	static DockBuilderFinish = function(node_id) {
		return __imgui_dock_builder_finish(node_id);
	}

	/**
	 * @function DockBuilderGetCentralNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @return {Pointer}
	 */
	static DockBuilderGetCentralNode = function(node_id) {
		return __imgui_dock_builder_get_central_node(node_id);
	}

	/**
	 * @function DockBuilderGetNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @return {Pointer}
	 */
	static DockBuilderGetNode = function(node_id) {
		return __imgui_dock_builder_get_node(node_id);
	}

	/**
	 * @function DockBuilderRemoveNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @return {Undefined}
	 */
	static DockBuilderRemoveNode = function(node_id) {
		return __imgui_dock_builder_remove_node(node_id);
	}

	/**
	 * @function DockBuilderRemoveNodeChildNodes
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @return {Undefined}
	 */
	static DockBuilderRemoveNodeChildNodes = function(node_id) {
		return __imgui_dock_builder_remove_node_child_nodes(node_id);
	}

	/**
	 * @function DockBuilderRemoveNodeDockedWindows
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @param {Bool} [clear_settings_refs=true]
	 * @return {Undefined}
	 */
	static DockBuilderRemoveNodeDockedWindows = function(node_id, clear_settings_refs=true) {
		return __imgui_dock_builder_remove_node_docked_windows(node_id, clear_settings_refs);
	}

	/**
	 * @function DockBuilderSetNodePos
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @param {Real} _x
	 * @param {Real} _y
	 * @return {Undefined}
	 */
	static DockBuilderSetNodePos = function(node_id, _x, _y) {
		return __imgui_dock_builder_set_node_pos(node_id, _x, _y);
	}

	/**
	 * @function DockBuilderSetNodeSize
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @param {Real} width
	 * @param {Real} height
	 * @return {Undefined}
	 */
	static DockBuilderSetNodeSize = function(node_id, width, height) {
		return __imgui_dock_builder_set_node_size(node_id, width, height);
	}

	/**
	 * @function DockBuilderSplitNode
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} node_id
	 * @param {Real} split_dir
	 * @param {Real} size_ratio_for_node_at_dir
	 * @return {Array<ImGuiID>}
	 */
	static DockBuilderSplitNode = function(node_id, split_dir, size_ratio_for_node_at_dir) {
		return __imgui_dock_builder_split_node(node_id, split_dir, size_ratio_for_node_at_dir);
	}

	/**
	 * @function DockSpace
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} _id
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {ImGuiDockNodeFlags} [flags=ImGuiDockNodeFlags.None]
	 * @param {ImGuiWindowClass} [window_class=undefined]
	 * @return {Real}
	 */
	static DockSpace = function(_id, width=0, height=0, flags=ImGuiDockNodeFlags.None, window_class=undefined) {
		return __imgui_dock_space(_id, width, height, flags, window_class);
	}

	/**
	 * @function DockSpaceOverViewport
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Any} [dockspace_id=0]
	 * @param {Real} [viewport_id=0]
	 * @param {Enum.ImGuiDockNodeFlags} [flags=ImGuiDockNodeFlags.None]
	 * @param {ImGuiWindowClass} [window_class=undefined]
	 * @return {Real}
	 */
	static DockSpaceOverViewport = function(dockspace_id=0, viewport_id=0, flags=ImGuiDockNodeFlags.None, window_class=undefined) {
		return __imgui_dock_space_over_viewport(dockspace_id, viewport_id, flags, window_class);
	}

	/**
	 * @function DragFloat
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * If v_min >= v_max we have no bound
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static DragFloat = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragFloat2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragFloat2 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float2(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragFloat3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragFloat3 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float3(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragFloat4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragFloat4 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float4(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragFloatN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragFloatN = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float_n(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
	}

	/**
	 * @function DragFloatRange2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format_min=%.3f]
	 * @param {String} [format_max=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragFloatRange2 = function(label, v, v_speed=1, v_min=0, v_max=0, format_min="%.3f", format_max="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_float_range2(label, v, v_speed, v_min, v_max, format_min, format_max, flags);
	}

	/**
	 * @function DragInt
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * If v_min >= v_max we have no bound
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static DragInt = function(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragInt2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragInt2 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int2(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragInt3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragInt3 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int3(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragInt4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragInt4 = function(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int4(label, v, v_speed, v_min, v_max, format, flags);
	}

	/**
	 * @function DragIntN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragIntN = function(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int_n(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
	}

	/**
	 * @function DragIntRange2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} v_current_max
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format_max=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static DragIntRange2 = function(label, v, v_current_max, v_speed=1, v_min=0, v_max=0, format_max="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_drag_int_range2(label, v, v_current_max, v_speed, v_min, v_max, format_max, flags);
	}

	/**
	 * @function DrawListAddBezierCubic
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} x4
	 * @param {Real} y4
	 * @param {Real} col
	 * @param {Real} thickness
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListAddBezierCubic = function(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness, num_segments=0) {
		return __imgui_drawlist_add_bezier_cubic(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness, num_segments);
	}

	/**
	 * @function DrawListAddBezierQuadratic
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} col
	 * @param {Real} thickness
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListAddBezierQuadratic = function(list, x1, y1, x2, y2, x3, y3, col, thickness, num_segments=0) {
		return __imgui_drawlist_add_bezier_quadratic(list, x1, y1, x2, y2, x3, y3, col, thickness, num_segments);
	}

	/**
	 * @function DrawListAddCircle
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} col
	 * @param {Real} [num_segments=0]
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddCircle = function(list, _x, _y, radius, col, num_segments=0, thickness=1) {
		return __imgui_drawlist_add_circle(list, _x, _y, radius, col, num_segments, thickness);
	}

	/**
	 * @function DrawListAddCircleFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} col
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListAddCircleFilled = function(list, _x, _y, radius, col, num_segments=0) {
		return __imgui_drawlist_add_circle_filled(list, _x, _y, radius, col, num_segments);
	}

	/**
	 * @function DrawListAddConvexPolyFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Array<Real>} positions
	 * @param {Real} col
	 * @return {Undefined}
	 */
	static DrawListAddConvexPolyFilled = function(list, positions, col) {
		return __imgui_drawlist_add_convex_poly_filled(list, positions, col, array_length(positions));
	}

	/**
	 * @function DrawListAddImage
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} sprite
	 * @param {Real} subimg
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} [col=c_white]
	 * @return {Undefined}
	 */
	static DrawListAddImage = function(list, sprite, subimg, x1, y1, x2, y2, col=c_white) {
		if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) texture_set_stage(0, sprite_get_texture(sprite, subimg)); 
		return __imgui_drawlist_add_image(list, sprite, subimg, x1, y1, x2, y2, col, sprite_get_uvs(sprite, subimg));
	}

	/**
	 * @function DrawListAddImageRounded
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} sprite
	 * @param {Real} subimg
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} col
	 * @param {Real} rounding
	 * @param {Real} flags
	 * @return {Undefined}
	 */
	static DrawListAddImageRounded = function(list, sprite, subimg, x1, y1, x2, y2, col, rounding, flags) {
		if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) texture_set_stage(0, sprite_get_texture(sprite, subimg)); 
		return __imgui_drawlist_add_image_rounded(list, sprite, subimg, x1, y1, x2, y2, col, rounding, flags, sprite_get_uvs(sprite, subimg));
	}

	/**
	 * @function DrawListAddLine
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} col
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddLine = function(list, x1, y1, x2, y2, col, thickness=1) {
		return __imgui_drawlist_add_line(list, x1, y1, x2, y2, col, thickness);
	}

	/**
	 * @function DrawListAddNgon
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} col
	 * @param {Real} [num_segments=0]
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddNgon = function(list, _x, _y, radius, col, num_segments=0, thickness=1) {
		return __imgui_drawlist_add_ngon(list, _x, _y, radius, col, num_segments, thickness);
	}

	/**
	 * @function DrawListAddNgonFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} col
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListAddNgonFilled = function(list, _x, _y, radius, col, num_segments=0) {
		return __imgui_drawlist_add_ngon_filled(list, _x, _y, radius, col, num_segments);
	}

	/**
	 * @function DrawListAddPolyline
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Array<Real>} positions
	 * @param {Real} col
	 * @param {Enum.ImDrawFlags} flags
	 * @param {Real} thickness
	 * @return {Undefined}
	 */
	static DrawListAddPolyline = function(list, positions, col, flags, thickness) {
		return __imgui_drawlist_add_polyline(list, positions, col, flags, thickness, array_length(positions));
	}

	/**
	 * @function DrawListAddQuad
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} x4
	 * @param {Real} y4
	 * @param {Real} col
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddQuad = function(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness=1) {
		return __imgui_drawlist_add_quad(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness);
	}

	/**
	 * @function DrawListAddQuadFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} x4
	 * @param {Real} y4
	 * @param {Real} col
	 * @return {Undefined}
	 */
	static DrawListAddQuadFilled = function(list, x1, y1, x2, y2, x3, y3, x4, y4, col) {
		return __imgui_drawlist_add_quad_filled(list, x1, y1, x2, y2, x3, y3, x4, y4, col);
	}

	/**
	 * @function DrawListAddRect
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} col
	 * @param {Real} [rounding=0]
	 * @param {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddRect = function(list, x1, y1, x2, y2, col, rounding=0, flags=ImDrawFlags.None, thickness=1) {
		return __imgui_drawlist_add_rect(list, x1, y1, x2, y2, col, rounding, flags, thickness);
	}

	/**
	 * @function DrawListAddRectFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} col
	 * @param {Real} [rounding=0]
	 * @param {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
	 * @return {Undefined}
	 */
	static DrawListAddRectFilled = function(list, x1, y1, x2, y2, col, rounding=0, flags=ImDrawFlags.None) {
		return __imgui_drawlist_add_rect_filled(list, x1, y1, x2, y2, col, rounding, flags);
	}

	/**
	 * @function DrawListAddRectFilledMultiColor
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} col1
	 * @param {Real} col2
	 * @param {Real} col3
	 * @param {Real} col4
	 * @return {Undefined}
	 */
	static DrawListAddRectFilledMultiColor = function(list, x1, y1, x2, y2, col1, col2, col3, col4) {
		return __imgui_drawlist_add_rect_filled_multicolor(list, x1, y1, x2, y2, col1, col2, col3, col4);
	}

	/**
	 * @function DrawListAddText
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {String} text
	 * @param {Real} col
	 * @return {Undefined}
	 */
	static DrawListAddText = function(list, _x, _y, text, col) {
		return __imgui_drawlist_add_text(list, _x, _y, text, col);
	}

	/**
	 * @function DrawListAddTextFont
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {String} text
	 * @param {Real} col
	 * @param {Pointer} font
	 * @param {Real} font_size
	 * @param {Real} [wrap_width=0]
	 * @return {Undefined}
	 */
	static DrawListAddTextFont = function(list, _x, _y, text, col, font, font_size, wrap_width=0) {
		return __imgui_drawlist_add_text_font(list, _x, _y, text, col, font, font_size, wrap_width);
	}

	/**
	 * @function DrawListAddTriangle
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} col
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListAddTriangle = function(list, x1, y1, x2, y2, x3, y3, col, thickness=1) {
		return __imgui_drawlist_add_triangle(list, x1, y1, x2, y2, x3, y3, col, thickness);
	}

	/**
	 * @function DrawListAddTriangleFilled
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} col
	 * @return {Undefined}
	 */
	static DrawListAddTriangleFilled = function(list, x1, y1, x2, y2, x3, y3, col) {
		return __imgui_drawlist_add_triangle_filled(list, x1, y1, x2, y2, x3, y3, col);
	}

	/**
	 * @function DrawListFlagsGet
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @return {Real}
	 */
	static DrawListFlagsGet = function(list) {
		return __imgui_drawlist_flags_get(list);
	}

	/**
	 * @function DrawListFlagsSet
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} flags
	 * @return {Undefined}
	 */
	static DrawListFlagsSet = function(list, flags) {
		return __imgui_drawlist_flags_set(list, flags);
	}

	/**
	 * @function DrawListFlagToggle
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} flag
	 * @return {Bool}
	 */
	static DrawListFlagToggle = function(list, flag) {
		return __imgui_drawlist_flag_toggle(list, flag);
	}

	/**
	 * @function DrawListPathArcTo
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} a_min
	 * @param {Real} a_max
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListPathArcTo = function(list, _x, _y, radius, a_min, a_max, num_segments=0) {
		return __imgui_drawlist_path_arc_to(list, _x, _y, radius, a_min, a_max, num_segments);
	}

	/**
	 * @function DrawListPathArcToFast
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Real} radius
	 * @param {Real} a_min_of_12
	 * @param {Real} a_max_of_12
	 * @return {Undefined}
	 */
	static DrawListPathArcToFast = function(list, _x, _y, radius, a_min_of_12, a_max_of_12) {
		return __imgui_drawlist_path_arc_to_fast(list, _x, _y, radius, a_min_of_12, a_max_of_12);
	}

	/**
	 * @function DrawListPathBezierCubicCurveTo
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} x4
	 * @param {Real} y4
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListPathBezierCubicCurveTo = function(list, x2, y2, x3, y3, x4, y4, num_segments=0) {
		return __imgui_drawlist_path_bezier_cubic_curve_to(list, x2, y2, x3, y3, x4, y4, num_segments);
	}

	/**
	 * @function DrawListPathBezierQuadraticCurveTo
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} x3
	 * @param {Real} y3
	 * @param {Real} [num_segments=0]
	 * @return {Undefined}
	 */
	static DrawListPathBezierQuadraticCurveTo = function(list, x2, y2, x3, y3, num_segments=0) {
		return __imgui_drawlist_path_bezier_quadratic_curve_to(list, x2, y2, x3, y3, num_segments);
	}

	/**
	 * @function DrawListPathClear
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @return {Undefined}
	 */
	static DrawListPathClear = function(list) {
		return __imgui_drawlist_path_clear(list);
	}

	/**
	 * @function DrawListPathFillConvex
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} col
	 * @return {Undefined}
	 */
	static DrawListPathFillConvex = function(list, col) {
		return __imgui_drawlist_path_fill_convex(list, col);
	}

	/**
	 * @function DrawListPathLineTo
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @return {Undefined}
	 */
	static DrawListPathLineTo = function(list, _x, _y) {
		return __imgui_drawlist_path_line_to(list, _x, _y);
	}

	/**
	 * @function DrawListPathLineToMergeDuplicate
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} _x
	 * @param {Real} _y
	 * @return {Undefined}
	 */
	static DrawListPathLineToMergeDuplicate = function(list, _x, _y) {
		return __imgui_drawlist_path_line_to_merge_duplicate(list, _x, _y);
	}

	/**
	 * @function DrawListPathRect
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @param {Real} [rounding=0]
	 * @param {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
	 * @return {Undefined}
	 */
	static DrawListPathRect = function(list, x1, y1, x2, y2, rounding=0, flags=ImDrawFlags.None) {
		return __imgui_drawlist_path_rect(list, x1, y1, x2, y2, rounding, flags);
	}

	/**
	 * @function DrawListPathStroke
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} col
	 * @param {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
	 * @param {Real} [thickness=1]
	 * @return {Undefined}
	 */
	static DrawListPathStroke = function(list, col, flags=ImDrawFlags.None, thickness=1) {
		return __imgui_drawlist_path_stroke(list, col, flags, thickness);
	}

	/**
	 * @function DrawListPopClipRect
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @return {Undefined}
	 */
	static DrawListPopClipRect = function(list) {
		return __imgui_drawlist_pop_clip_rect(list);
	}

	/**
	 * @function DrawListPopTextureID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @return {Undefined}
	 */
	static DrawListPopTextureID = function(list) {
		return __imgui_drawlist_pop_textureid(list);
	}

	/**
	 * @function DrawListPushClipRect
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} clip_min_x
	 * @param {Real} clip_min_y
	 * @param {Real} clip_max_x
	 * @param {Real} clip_max_y
	 * @param {Bool} intersect_with_current_clip_rect
	 * @return {Undefined}
	 */
	static DrawListPushClipRect = function(list, clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect) {
		return __imgui_drawlist_push_clip_rect(list, clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect);
	}

	/**
	 * @function DrawlistPushClipRectFullscreen
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @return {Undefined}
	 */
	static DrawlistPushClipRectFullscreen = function(list) {
		return __imgui_drawlist_push_clip_rect_fullscreen(list);
	}

	/**
	 * @function DrawListPushTextureID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Pointer} list
	 * @param {Real} sprite
	 * @param {Real} subimg
	 * @return {Undefined}
	 */
	static DrawListPushTextureID = function(list, sprite, subimg) {
		if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) texture_set_stage(0, sprite_get_texture(sprite, subimg)); 
		return __imgui_drawlist_push_textureid(list, sprite, subimg);
	}

	/**
	 * @function Dummy
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add a dummy item of given size. unlike InvisibleButton(), Dummy() won't take the mouse click or be navigable into.
	 *
	 * @param {Real} width
	 * @param {Real} height
	 * @return {Undefined}
	 */
	static Dummy = function(width, height) {
		return __imgui_dummy(width, height);
	}

	/**
	 * @function End
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Child Windows
	 *
	 * @return {Undefined}
	 */
	static End = function() {
		return __imgui_end();
	}

	/**
	 * @function EndChild
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Windows Utilities
	 *
	 * @return {Undefined}
	 */
	static EndChild = function() {
		return __imgui_end_child();
	}

	/**
	 * @function EndChildFrame
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static EndChildFrame = function() {
		return __imgui_end_child_frame();
	}

	/**
	 * @function EndCombo
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndCombo() if BeginCombo() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndCombo = function() {
		return __imgui_end_combo();
	}

	/**
	 * @function EndDisabled
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Clipping
	 *
	 * @return {Undefined}
	 */
	static EndDisabled = function() {
		return __imgui_end_disabled();
	}

	/**
	 * @function EndDragDropSource
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndDragDropSource() if BeginDragDropSource() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndDragDropSource = function() {
		return __imgui_end_drag_drop_source();
	}

	/**
	 * @function EndDragDropTarget
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndDragDropTarget() if BeginDragDropTarget() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndDragDropTarget = function() {
		return __imgui_end_drag_drop_target();
	}

	/**
	 * @function EndGroup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * unlock horizontal starting position + capture the whole group bounding box into one "item" (so you can use IsItemHovered() or layout primitives such as SameLine() on whole group, etc.)
	 *
	 * @return {Undefined}
	 */
	static EndGroup = function() {
		return __imgui_end_group();
	}

	/**
	 * @function EndListBox
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndListBox() if BeginListBox() returned true!
	 *
	 * @return {Undefined}
	 */
	static EndListBox = function() {
		return __imgui_end_list_box();
	}

	/**
	 * @function EndMainMenuBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndMainMenuBar() if BeginMainMenuBar() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndMainMenuBar = function() {
		return __imgui_end_main_menu_bar();
	}

	/**
	 * @function EndMenu
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndMenu() if BeginMenu() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndMenu = function() {
		return __imgui_end_menu();
	}

	/**
	 * @function EndMenuBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndMenuBar() if BeginMenuBar() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndMenuBar = function() {
		return __imgui_end_menu_bar();
	}

	/**
	 * @function EndMultiSelect
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {ImGuiMultiSelectIO}
	 */
	static EndMultiSelect = function() {
		return __imgui_end_multi_select();
	}

	/**
	 * @function EndPopup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndPopup() if BeginPopupXXX() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndPopup = function() {
		return __imgui_end_popup();
	}

	/**
	 * @function EndTabBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndTabBar() if BeginTabBar() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndTabBar = function() {
		return __imgui_end_tab_bar();
	}

	/**
	 * @function EndTabItem
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndTabItem() if BeginTabItem() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndTabItem = function() {
		return __imgui_end_tab_item();
	}

	/**
	 * @function EndTable
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndTable() if BeginTable() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndTable = function() {
		return __imgui_end_table();
	}

	/**
	 * @function EndTooltip
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * only call EndTooltip() if BeginTooltip()/BeginItemTooltip() returns true!
	 *
	 * @return {Undefined}
	 */
	static EndTooltip = function() {
		return __imgui_end_tooltip();
	}

	/**
	 * @function FindViewportByID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} _id
	 * @return {ImGuiViewport}
	 */
	static FindViewportByID = function(_id) {
		return __imgui_find_viewport_by_id(_id);
	}

	/**
	 * @function FindViewportByPlatformHandle
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * this is a helper for backends. the type platform_handle is decided by the backend (e.g. HWND, MyWindow*, GLFWwindow* etc.)
	 *
	 * @param {HWND} platform_handle
	 * @return {ImGuiViewport}
	 */
	static FindViewportByPlatformHandle = function(platform_handle) {
		return __imgui_find_viewport_by_platform_handle(platform_handle);
	}

	/**
	 * @function GetBackgroundDrawList
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get background draw list for the given viewport or viewport associated to the current window. this draw list will be the first rendering one. Useful to quickly draw shapes/text behind dear imgui contents.
	 *
	 * @param {Pointer} [viewport=undefined]
	 * @return {Pointer}
	 */
	static GetBackgroundDrawList = function(viewport=undefined) {
		return __imgui_get_background_draw_list(viewport);
	}

	/**
	 * @function GetColumnIndex
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get current column index
	 *
	 * @return {Real}
	 */
	static GetColumnIndex = function() {
		return __imgui_get_column_index();
	}

	/**
	 * @function GetColumnOffset
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get position of column line (in pixels, from the left side of the contents region). pass -1 to use current column, otherwise 0..GetColumnsCount() inclusive. column 0 is typically 0.0f
	 *
	 * @param {Real} [column_index=-1]
	 * @return {Real}
	 */
	static GetColumnOffset = function(column_index=-1) {
		return __imgui_get_column_offset(column_index);
	}

	/**
	 * @function GetColumnsCount
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Tab Bars, Tabs
	 *
	 * @return {Real}
	 */
	static GetColumnsCount = function() {
		return __imgui_get_columns_count();
	}

	/**
	 * @function GetColumnWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get column width (in pixels). pass -1 to use current column
	 *
	 * @param {Real} [column_index=-1]
	 * @return {Real}
	 */
	static GetColumnWidth = function(column_index=-1) {
		return __imgui_get_column_width(column_index);
	}

	/**
	 * @function GetContentRegionAvailX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetContentRegionAvailX = function() {
		return __imgui_get_content_region_avail_x();
	}

	/**
	 * @function GetContentRegionAvailY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetContentRegionAvailY = function() {
		return __imgui_get_content_region_avail_y();
	}

	/**
	 * @function GetContentRegionMaxX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetContentRegionMaxX = function() {
		return __imgui_get_content_region_max_x();
	}

	/**
	 * @function GetContentRegionMaxY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetContentRegionMaxY = function() {
		return __imgui_get_content_region_max_y();
	}

	/**
	 * @function GetCurrentContext
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Pointer}
	 */
	static GetCurrentContext = function() {
		return __imgui_get_current_context();
	}

	/**
	 * @function GetCursorPosX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [window-local] "
	 *
	 * @return {Real}
	 */
	static GetCursorPosX = function() {
		return __imgui_get_cursor_pos_x();
	}

	/**
	 * @function GetCursorPosY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [window-local] "
	 *
	 * @return {Real}
	 */
	static GetCursorPosY = function() {
		return __imgui_get_cursor_pos_y();
	}

	/**
	 * @function GetCursorScreenPosX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetCursorScreenPosX = function() {
		return __imgui_get_cursor_screen_pos_x();
	}

	/**
	 * @function GetCursorScreenPosY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetCursorScreenPosY = function() {
		return __imgui_get_cursor_screen_pos_y();
	}

	/**
	 * @function GetCursorStartPosX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetCursorStartPosX = function() {
		return __imgui_get_cursor_start_pos_x();
	}

	/**
	 * @function GetCursorStartPosY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetCursorStartPosY = function() {
		return __imgui_get_cursor_start_pos_y();
	}

	/**
	 * @function GetDragDropPayload
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * peek directly into the current payload from anywhere. returns NULL when drag and drop is finished or inactive. use ImGuiPayload::IsDataType() to test for the payload type.
	 *
	 * @return {Any|Undefined}
	 */
	static GetDragDropPayload = function() {
		return __imgui_get_drag_drop_payload();
	}

	/**
	 * @function GetDragDropPayloadType
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {String|Undefined}
	 */
	static GetDragDropPayloadType = function() {
		return __imgui_get_payload_type();
	}

	/**
	 * @function GetFont
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get current font
	 *
	 * @return {Pointer}
	 */
	static GetFont = function() {
		return __imgui_get_font();
	}

	/**
	 * @function GetFontSize
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get current scaled font size (= height in pixels). AFTER global scale factors applied. *IMPORTANT* DO NOT PASS THIS VALUE TO PushFont()! Use ImGui::GetStyle().FontSizeBase to get value before global scale factors.
	 *
	 * @return {Real}
	 */
	static GetFontSize = function() {
		return __imgui_get_font_size();
	}

	/**
	 * @function GetForegroundDrawList
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get foreground draw list for the given viewport or viewport associated to the current window. this draw list will be the top-most rendered one. Useful to quickly draw shapes/text over dear imgui contents.
	 *
	 * @param {Pointer} [viewport=undefined]
	 * @return {Pointer}
	 */
	static GetForegroundDrawList = function(viewport=undefined) {
		return __imgui_get_foreground_draw_list(viewport);
	}

	/**
	 * @function GetFrameCount
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get global imgui frame count. incremented by 1 every frame.
	 *
	 * @return {Real}
	 */
	static GetFrameCount = function() {
		return __imgui_get_frame_count();
	}

	/**
	 * @function GetFrameHeight
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ FontSize + style.FramePadding.y * 2
	 *
	 * @return {Real}
	 */
	static GetFrameHeight = function() {
		return __imgui_get_frame_height();
	}

	/**
	 * @function GetFrameHeightWithSpacing
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ FontSize + style.FramePadding.y * 2 + style.ItemSpacing.y (distance in pixels between 2 consecutive lines of framed widgets)
	 *
	 * @return {Real}
	 */
	static GetFrameHeightWithSpacing = function() {
		return __imgui_get_frame_height_with_spacing();
	}

	/**
	 * @function GetID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} str_id
	 * @return {Real}
	 */
	static GetID = function(str_id) {
		return __imgui_get_id(str_id);
	}

	/**
	 * @function GetItemID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemID = function() {
		return __imgui_get_item_id();
	}

	/**
	 * @function GetItemRectMaxX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectMaxX = function() {
		return __imgui_get_item_rect_max_x();
	}

	/**
	 * @function GetItemRectMaxY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectMaxY = function() {
		return __imgui_get_item_rect_max_y();
	}

	/**
	 * @function GetItemRectMinX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectMinX = function() {
		return __imgui_get_item_rect_min_x();
	}

	/**
	 * @function GetItemRectMinY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectMinY = function() {
		return __imgui_get_item_rect_min_y();
	}

	/**
	 * @function GetItemRectSizeHeight
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectSizeHeight = function() {
		return __imgui_get_item_rect_size_height();
	}

	/**
	 * @function GetItemRectSizeWidth
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetItemRectSizeWidth = function() {
		return __imgui_get_item_rect_size_width();
	}

	/**
	 * @function GetKeyChordName
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiKeyChord} key_chord
	 * @return {String}
	 */
	static GetKeyChordName = function(key_chord) {
		return __imgui_get_key_chord_name(key_chord);
	}

	/**
	 * @function GetKeyName
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [DEBUG] returns English name of the key. Those names are provided for debugging purpose and are not meant to be saved persistently nor compared.
	 *
	 * @param {ImGuiKey} key
	 * @return {String}
	 */
	static GetKeyName = function(key) {
		return __imgui_get_key_name(key);
	}

	/**
	 * @function GetKeyPressedAmount
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if RepeatRate is small enough that DeltaTime > RepeatRate
	 *
	 * @param {ImGuiKey} key
	 * @param {Float} repeat_delay
	 * @param {Float} rate
	 * @return {Real}
	 */
	static GetKeyPressedAmount = function(key, repeat_delay, rate) {
		return __imgui_get_key_pressed_amount(key, repeat_delay, rate);
	}

	/**
	 * @function GetMainViewport
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return primary/default viewport. This can never be NULL.
	 *
	 * @return {Pointer}
	 */
	static GetMainViewport = function() {
		return __imgui_get_main_viewport();
	}

	/**
	 * @function GetMouseClickedCount
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
	 *
	 * @param {ImGuiMouseButton} button
	 * @return {Real}
	 */
	static GetMouseClickedCount = function(button) {
		return __imgui_get_mouse_clicked_count(button);
	}

	/**
	 * @function GetMouseDragDeltaX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {Float} [lock_threshold=-1]
	 * @return {Real}
	 */
	static GetMouseDragDeltaX = function(button, lock_threshold=-1) {
		return __imgui_get_mouse_drag_delta_x(button, lock_threshold);
	}

	/**
	 * @function GetMouseDragDeltaY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {Float} [lock_threshold=-1]
	 * @return {Real}
	 */
	static GetMouseDragDeltaY = function(button, lock_threshold=-1) {
		return __imgui_get_mouse_drag_delta_y(button, lock_threshold);
	}

	/**
	 * @function GetMousePosOnOpeningCurrentPopupX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetMousePosOnOpeningCurrentPopupX = function() {
		return __imgui_get_mouse_pos_on_opening_current_popup_x();
	}

	/**
	 * @function GetMousePosOnOpeningCurrentPopupY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetMousePosOnOpeningCurrentPopupY = function() {
		return __imgui_get_mouse_pos_on_opening_current_popup_y();
	}

	/**
	 * @function GetMousePosX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetMousePosX = function() {
		return __imgui_get_mouse_pos_x();
	}

	/**
	 * @function GetMousePosY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetMousePosY = function() {
		return __imgui_get_mouse_pos_y();
	}

	/**
	 * @function GetScrollMaxX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get maximum scrolling amount ~~ ContentSize.x - WindowSize.x - DecorationsSize.x
	 *
	 * @return {Real}
	 */
	static GetScrollMaxX = function() {
		return __imgui_get_scroll_max_x();
	}

	/**
	 * @function GetScrollMaxY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get maximum scrolling amount ~~ ContentSize.y - WindowSize.y - DecorationsSize.y
	 *
	 * @return {Real}
	 */
	static GetScrollMaxY = function() {
		return __imgui_get_scroll_max_y();
	}

	/**
	 * @function GetScrollX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get scrolling amount [0 .. GetScrollMaxX()]
	 *
	 * @return {Real}
	 */
	static GetScrollX = function() {
		return __imgui_get_scroll_x();
	}

	/**
	 * @function GetScrollY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get scrolling amount [0 .. GetScrollMaxY()]
	 *
	 * @return {Real}
	 */
	static GetScrollY = function() {
		return __imgui_get_scroll_y();
	}

	/**
	 * @function GetStyleColor
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} idx
	 * @return {Real}
	 */
	static GetStyleColor = function(idx) {
		return __imgui_get_style_color(idx);
	}

	/**
	 * @function GetStyleColorName
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get a string corresponding to the enum value (for display, saving, etc.).
	 *
	 * @param {Real} idx
	 * @return {String}
	 */
	static GetStyleColorName = function(idx) {
		return __imgui_get_style_color_name(idx);
	}

	/**
	 * @function GetTextLineHeight
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ FontSize
	 *
	 * @return {Real}
	 */
	static GetTextLineHeight = function() {
		return __imgui_get_text_line_height();
	}

	/**
	 * @function GetTextLineHeightWithSpacing
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ FontSize + style.ItemSpacing.y (distance in pixels between 2 consecutive lines of text)
	 *
	 * @return {Real}
	 */
	static GetTextLineHeightWithSpacing = function() {
		return __imgui_get_text_line_height_with_spacing();
	}

	/**
	 * @function GetTime
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get global imgui time. incremented by io.DeltaTime every frame.
	 *
	 * @return {Real}
	 */
	static GetTime = function() {
		return __imgui_get_time();
	}

	/**
	 * @function GetTreeNodeToLabelSpacing
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * horizontal distance preceding label when using TreeNode*() or Bullet() == (g.FontSize + style.FramePadding.x*2) for a regular unframed TreeNode
	 *
	 * @return {Real}
	 */
	static GetTreeNodeToLabelSpacing = function() {
		return __imgui_get_tree_node_to_label_spacing();
	}

	/**
	 * @function GetVersion
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get the compiled version string e.g. "1.80 WIP" (essentially the value for IMGUI_VERSION from the compiled version of imgui.cpp)
	 *
	 * @return {String}
	 */
	static GetVersion = function() {
		return __imgui_get_version();
	}

	/**
	 * @function GetViewportID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiViewport} vp
	 * @return {ImGuiID}
	 */
	static GetViewportID = function(vp) {
		return __imgui_get_viewport_id(vp);
	}

	/**
	 * @function GetWindowContentRegionMaxX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowContentRegionMaxX = function() {
		return __imgui_get_window_content_region_max_x();
	}

	/**
	 * @function GetWindowContentRegionMaxY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowContentRegionMaxY = function() {
		return __imgui_get_window_content_region_max_y();
	}

	/**
	 * @function GetWindowContentRegionMinX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowContentRegionMinX = function() {
		return __imgui_get_window_content_region_min_x();
	}

	/**
	 * @function GetWindowContentRegionMinY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowContentRegionMinY = function() {
		return __imgui_get_window_content_region_min_y();
	}

	/**
	 * @function GetWindowDockID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowDockID = function() {
		return __imgui_get_window_dock_id();
	}

	/**
	 * @function GetWindowDpiScale
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get DPI scale currently associated to the current window's viewport.
	 *
	 * @return {Real}
	 */
	static GetWindowDpiScale = function() {
		return __imgui_get_window_dpi_scale();
	}

	/**
	 * @function GetWindowDrawList
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get draw list associated to the current window, to append your own drawing primitives
	 *
	 * @return {Pointer}
	 */
	static GetWindowDrawList = function() {
		return __imgui_get_window_draw_list();
	}

	/**
	 * @function GetWindowHeight
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get current window height (IT IS UNLIKELY YOU EVER NEED TO USE THIS). Shortcut for GetWindowSize().y.
	 *
	 * @return {Real}
	 */
	static GetWindowHeight = function() {
		return __imgui_get_window_height();
	}

	/**
	 * @function GetWindowPosX
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowPosX = function() {
		return __imgui_get_window_x();
	}

	/**
	 * @function GetWindowPosY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Real}
	 */
	static GetWindowPosY = function() {
		return __imgui_get_window_y();
	}

	/**
	 * @function GetWindowViewport
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get viewport currently associated to the current window.
	 *
	 * @return {Pointer}
	 */
	static GetWindowViewport = function() {
		return __imgui_get_window_viewport();
	}

	/**
	 * @function GetWindowWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * get current window width (IT IS UNLIKELY YOU EVER NEED TO USE THIS). Shortcut for GetWindowSize().x.
	 *
	 * @return {Real}
	 */
	static GetWindowWidth = function() {
		return __imgui_get_window_width();
	}

	/**
	 * @function Image
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} sprite
	 * @param {Real} subimg
	 * @param {Real} [color=c_white]
	 * @param {Real} [alpha=1]
	 * @param {Real} [width=sprite_get_width⌊sprite⌉]
	 * @param {Real} [height=sprite_get_height⌊sprite⌉]
	 * @return {Undefined}
	 */
	static Image = function(sprite, subimg, color=c_white, alpha=1, width=sprite_get_width(sprite), height=sprite_get_height(sprite)) {
		if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) texture_set_stage(0, sprite_get_texture(sprite, subimg)); 
		return __imgui_image(sprite, subimg, color, alpha, width, height, sprite_get_uvs(sprite, subimg));
	}

	/**
	 * @function ImageButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Widgets: Combo Box (Dropdown)
	 *
	 * @param {String} str_id
	 * @param {Real} sprite
	 * @param {Real} subimg
	 * @param {Real} color
	 * @param {Real} alpha
	 * @param {Real} bg_color
	 * @param {Real} bg_alpha
	 * @param {Real} [width=sprite_get_width⌊sprite⌉]
	 * @param {Real} [height=sprite_get_height⌊sprite⌉]
	 * @return {Bool}
	 */
	static ImageButton = function(str_id, sprite, subimg, color, alpha, bg_color, bg_alpha, width=sprite_get_width(sprite), height=sprite_get_height(sprite)) {
		if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) texture_set_stage(0, sprite_get_texture(sprite, subimg)); 
		return __imgui_image_button(str_id, sprite, subimg, color, alpha, bg_color, bg_alpha, width, height, sprite_get_uvs(sprite, subimg));
	}

	/**
	 * @function Indent
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * move content position toward the right, by indent_w, or style.IndentSpacing if indent_w <= 0
	 *
	 * @param {Real} [indent_w=0]
	 * @return {Undefined}
	 */
	static Indent = function(indent_w=0) {
		return __imgui_indent(indent_w);
	}

	/**
	 * @function IniFilename
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} [val=undefined]
	 * @return {String}
	 */
	static IniFilename = function(val="undefined") {
		return __imgui_ini_filename(val);
	}

	/**
	 * @function InputDouble
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [step=1]
	 * @param {Real} [step_fast=5]
	 * @param {String} [format=%.6f]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Real}
	 */
	static InputDouble = function(label, v, step=1, step_fast=5, format="%.6f", flags=ImGuiInputTextFlags.None) {
		return __imgui_input_double(label, v, step, step_fast, format, flags);
	}

	/**
	 * @function InputFloat
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [step=0.1]
	 * @param {Real} [step_fast=0.25]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Real}
	 */
	static InputFloat = function(label, v, step=0.1, step_fast=0.25, format="%.3f", flags=ImGuiInputTextFlags.None) {
		return __imgui_input_float(label, v, step, step_fast, format, flags);
	}

	/**
	 * @function InputFloat2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [step=0.1]
	 * @param {Real} [step_fast=0.25]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputFloat2 = function(label, v, step=0.1, step_fast=0.25, format="%.3f", flags=ImGuiInputTextFlags.None) {
		return __imgui_input_float2(label, v, step, step_fast, format, flags);
	}

	/**
	 * @function InputFloat3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [step=0.1]
	 * @param {Real} [step_fast=0.25]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputFloat3 = function(label, v, step=0.1, step_fast=0.25, format="%.3f", flags=ImGuiInputTextFlags.None) {
		return __imgui_input_float3(label, v, step, step_fast, format, flags);
	}

	/**
	 * @function InputFloat4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [step=0.1]
	 * @param {Real} [step_fast=0.25]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputFloat4 = function(label, v, step=0.1, step_fast=0.25, format="%.3f", flags=ImGuiInputTextFlags.None) {
		return __imgui_input_float4(label, v, step, step_fast, format, flags);
	}

	/**
	 * @function InputFloatN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} len
	 * @param {Real} [step=0.1]
	 * @param {Real} [step_fast=0.25]
	 * @param {String} [format=%.3f]
	 * @return {Bool}
	 */
	static InputFloatN = function(label, v, len, step=0.1, step_fast=0.25, format="%.3f") {
		return __imgui_input_float_n(label, v, len, step, step_fast, format, array_length(v));
	}

	/**
	 * @function InputInt
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [step=1]
	 * @param {Real} [step_fast=5]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Real}
	 */
	static InputInt = function(label, v, step=1, step_fast=5, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_int(label, v, step, step_fast, flags);
	}

	/**
	 * @function InputInt2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputInt2 = function(label, v, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_int2(label, v, flags);
	}

	/**
	 * @function InputInt3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputInt3 = function(label, v, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_int3(label, v, flags);
	}

	/**
	 * @function InputInt4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputInt4 = function(label, v, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_int4(label, v, flags);
	}

	/**
	 * @function InputIntN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {Bool}
	 */
	static InputIntN = function(label, v, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_int_n(label, v, flags, array_length(v));
	}

	/**
	 * @function InputText
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} val
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {String}
	 */
	static InputText = function(label, val, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_text(label, val, flags);
	}

	/**
	 * @function InputTextMultiline
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} val
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {String}
	 */
	static InputTextMultiline = function(label, val, width=0, height=0, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_text_multiline(label, val, width, height, flags);
	}

	/**
	 * @function InputTextWithHint
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} hint
	 * @param {String} val
	 * @param {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
	 * @return {String}
	 */
	static InputTextWithHint = function(label, hint, val, flags=ImGuiInputTextFlags.None) {
		return __imgui_input_text_with_hint(label, hint, val, flags);
	}

	/**
	 * @function InvisibleButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with IsItemActive, IsItemHovered, etc.)
	 *
	 * @param {String} _id
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {Enum.ImGuiButtonFlags} [flags=ImGuiButtonFlags.None]
	 * @return {Bool}
	 */
	static InvisibleButton = function(_id, width=0, height=0, flags=ImGuiButtonFlags.None) {
		return __imgui_invisible_button(_id, width, height, flags);
	}

	/**
	 * @function IsAnyItemActive
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is any item active?
	 *
	 * @return {Bool}
	 */
	static IsAnyItemActive = function() {
		return __imgui_is_any_item_active();
	}

	/**
	 * @function IsAnyItemFocused
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is any item focused?
	 *
	 * @return {Bool}
	 */
	static IsAnyItemFocused = function() {
		return __imgui_is_any_item_focused();
	}

	/**
	 * @function IsAnyItemHovered
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is any item hovered?
	 *
	 * @return {Bool}
	 */
	static IsAnyItemHovered = function() {
		return __imgui_is_any_item_hovered();
	}

	/**
	 * @function IsAnyMouseDown
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [WILL OBSOLETE] is any mouse button held? This was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
	 *
	 * @return {Bool}
	 */
	static IsAnyMouseDown = function() {
		return __imgui_is_any_mouse_down();
	}

	/**
	 * @function IsItemActivated
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was the last item just made active (item was previously inactive).
	 *
	 * @return {Bool}
	 */
	static IsItemActivated = function() {
		return __imgui_is_item_activated();
	}

	/**
	 * @function IsItemActive
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is the last item active? (e.g. button being held, text field being edited. This will continuously return true while holding mouse button on an item. Items that don't interact will always return false)
	 *
	 * @return {Bool}
	 */
	static IsItemActive = function() {
		return __imgui_is_item_active();
	}

	/**
	 * @function IsItemClicked
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is the last item hovered and mouse clicked on? (**)  == IsMouseClicked(mouse_button) && IsItemHovered()Important. (**) this is NOT equivalent to the behavior of e.g. Button(). Read comments in function definition.
	 *
	 * @param {Enum.ImGuiMouseButton} [mouse_button=ImGuiMouseButton.Left]
	 * @return {Bool}
	 */
	static IsItemClicked = function(mouse_button=ImGuiMouseButton.Left) {
		return __imgui_is_item_clicked(mouse_button);
	}

	/**
	 * @function IsItemDeactivated
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that require continuous editing.
	 *
	 * @return {Bool}
	 */
	static IsItemDeactivated = function() {
		return __imgui_is_item_deactivated();
	}

	/**
	 * @function IsItemDeactivatedAfterEdit
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was the last item just made inactive and made a value change when it was active? (e.g. Slider/Drag moved). Useful for Undo/Redo patterns with widgets that require continuous editing. Note that you may get false positives (some widgets such as Combo()/ListBox()/Selectable() will return true even when clicking an already selected item).
	 *
	 * @return {Bool}
	 */
	static IsItemDeactivatedAfterEdit = function() {
		return __imgui_is_item_deactivated_after_edit();
	}

	/**
	 * @function IsItemEdited
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * did the last item modify its underlying value this frame? or was pressed? This is generally the same as the "bool" return value of many widgets.
	 *
	 * @return {Bool}
	 */
	static IsItemEdited = function() {
		return __imgui_is_item_edited();
	}

	/**
	 * @function IsItemFocused
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is the last item focused for keyboard/gamepad navigation?
	 *
	 * @return {Bool}
	 */
	static IsItemFocused = function() {
		return __imgui_is_item_focused();
	}

	/**
	 * @function IsItemHovered
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is the last item hovered? (and usable, aka not blocked by a popup, etc.). See ImGuiHoveredFlags for more options.
	 *
	 * @param {Enum.ImGuiHoveredFlags} [flags=ImGuiHoveredFlags.None]
	 * @return {Bool}
	 */
	static IsItemHovered = function(flags=ImGuiHoveredFlags.None) {
		return __imgui_is_item_hovered(flags);
	}

	/**
	 * @function IsItemToggledOpen
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was the last item open state toggled? set by TreeNode().
	 *
	 * @return {Bool}
	 */
	static IsItemToggledOpen = function() {
		return __imgui_is_item_toggled_open();
	}

	/**
	 * @function IsItemToggledSelection
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Was the last item selection state toggled? Useful if you need the per-item information _before_ reaching EndMultiSelect(). We only returns toggle _event_ in order to handle clipping correctly.
	 *
	 * @return {Bool}
	 */
	static IsItemToggledSelection = function() {
		return __imgui_is_item_toggled_selection();
	}

	/**
	 * @function IsItemVisible
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is the last item visible? (items may be out of sight because of clipping/scrolling)
	 *
	 * @return {Bool}
	 */
	static IsItemVisible = function() {
		return __imgui_is_item_visible();
	}

	/**
	 * @function IsKeyChordPressed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was key chord (mods + key) pressed, e.g. you can pass 'ImGuiMod_Ctrl | ImGuiKey_S' as a key-chord. This doesn't do any routing or focus check, please consider using Shortcut() function instead.
	 *
	 * @param {ImGuiKeyChord} key_chord
	 * @param {ImGuiInputFlags} [flags=undefined]
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsKeyChordPressed = function(key_chord, flags=undefined, owner_id=undefined) {
		return __imgui_is_key_chord_pressed(key_chord, flags, owner_id);
	}

	/**
	 * @function IsKeyDown
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is key being held.
	 *
	 * @param {ImGuiKey} key
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsKeyDown = function(key, owner_id=undefined) {
		return __imgui_is_key_down(key, owner_id);
	}

	/**
	 * @function IsKeyPressed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was key pressed (went from !Down to Down)? if repeat=true, uses io.KeyRepeatDelay / KeyRepeatRate
	 *
	 * @param {ImGuiKey} key
	 * @param {Bool} [_repeat=undefined]
	 * @return {Bool}
	 */
	static IsKeyPressed = function(key, _repeat=undefined) {
		return __imgui_is_key_pressed(key, _repeat);
	}

	/**
	 * @function IsKeyReleased
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * was key released (went from Down to !Down)?
	 *
	 * @param {ImGuiKey} key
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsKeyReleased = function(key, owner_id=undefined) {
		return __imgui_is_key_released(key, owner_id);
	}

	/**
	 * @function IsMouseClicked
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * did mouse button clicked? (went from !Down to Down). Same as GetMouseClickedCount() == 1.
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {Bool|ImGuiInputFlags} [repeat_or_flags=undefined]
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsMouseClicked = function(button, repeat_or_flags=undefined, owner_id=undefined) {
		return __imgui_is_mouse_clicked(button, repeat_or_flags, owner_id);
	}

	/**
	 * @function IsMouseDoubleClicked
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * did mouse button double-clicked? Same as GetMouseClickedCount() == 2. (note that a double-click will also report IsMouseClicked() == true)
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsMouseDoubleClicked = function(button, owner_id=undefined) {
		return __imgui_is_mouse_double_clicked(button, owner_id);
	}

	/**
	 * @function IsMouseDown
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is mouse button held?
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsMouseDown = function(button, owner_id=undefined) {
		return __imgui_is_mouse_down(button, owner_id);
	}

	/**
	 * @function IsMouseDragging
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is mouse dragging? (uses io.MouseDraggingThreshold if lock_threshold < 0.0f)
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {Float} [lock_threshold=-1]
	 * @return {Bool}
	 */
	static IsMouseDragging = function(button, lock_threshold=-1) {
		return __imgui_is_mouse_dragging(button, lock_threshold);
	}

	/**
	 * @function IsMouseHoveringRect
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
	 *
	 * @param {Real} min_x
	 * @param {Real} min_y
	 * @param {Real} max_x
	 * @param {Real} max_y
	 * @param {Bool} [clip=true]
	 * @return {Bool}
	 */
	static IsMouseHoveringRect = function(min_x, min_y, max_x, max_y, clip=true) {
		return __imgui_is_mouse_hovering_rect(min_x, min_y, max_x, max_y, clip);
	}

	/**
	 * @function IsMousePosValid
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * by convention we use (-FLT_MAX,-FLT_MAX) to denote that there is no mouse available
	 *
	 * @param {Real} mouse_x
	 * @param {Real} mouse_y
	 * @return {Bool}
	 */
	static IsMousePosValid = function(mouse_x, mouse_y) {
		return __imgui_is_mouse_pos_valid(mouse_x, mouse_y);
	}

	/**
	 * @function IsMouseReleased
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * did mouse button released? (went from Down to !Down)
	 *
	 * @param {ImGuiMouseButton} button
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static IsMouseReleased = function(button, owner_id=undefined) {
		return __imgui_is_mouse_released(button, owner_id);
	}

	/**
	 * @function IsPopupOpen
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return true if the popup is open.
	 *
	 * @param {String} str_id
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.None]
	 * @return {Bool}
	 */
	static IsPopupOpen = function(str_id, flags=ImGuiPopupFlags.None) {
		return __imgui_is_popup_open(str_id, flags);
	}

	/**
	 * @function IsRectVisible
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * test if rectangle (of given size, starting from cursor position) is visible / not clipped.
	 *
	 * @param {Real} x1
	 * @param {Real} y1
	 * @param {Real} x2
	 * @param {Real} y2
	 * @return {Bool}
	 */
	static IsRectVisible = function(x1, y1, x2, y2) {
		return __imgui_is_rect_visible(x1, y1, x2, y2);
	}

	/**
	 * @function IsWindowAppearing
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Bool}
	 */
	static IsWindowAppearing = function() {
		return __imgui_is_window_appearing();
	}

	/**
	 * @function IsWindowCollapsed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Bool}
	 */
	static IsWindowCollapsed = function() {
		return __imgui_is_window_collapsed();
	}

	/**
	 * @function IsWindowDocked
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is current window docked into another window?
	 *
	 * @return {Bool}
	 */
	static IsWindowDocked = function() {
		return __imgui_is_window_docked();
	}

	/**
	 * @function IsWindowFocused
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is current window focused? or its root/child, depending on flags. see flags for options.
	 *
	 * @param {Enum.ImGuiFocusedFlags} [flags=ImGuiFocusedFlags.None]
	 * @return {Bool}
	 */
	static IsWindowFocused = function(flags=ImGuiFocusedFlags.None) {
		return __imgui_is_window_focused(flags);
	}

	/**
	 * @function IsWindowHovered
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * is current window hovered and hoverable (e.g. not blocked by a popup/modal)? See ImGuiHoveredFlags_ for options. IMPORTANT: If you are trying to check whether your mouse should be dispatched to Dear ImGui or to your underlying app, you should not use this function! Use the 'io.WantCaptureMouse' boolean for that! Refer to FAQ entry "How can I tell whether to dispatch mouse/keyboard to Dear ImGui or my application?" for details.
	 *
	 * @param {Enum.ImGuiHoveredFlags} [flags=ImGuiHoveredFlags.None]
	 * @return {Bool}
	 */
	static IsWindowHovered = function(flags=ImGuiHoveredFlags.None) {
		return __imgui_is_window_hovered(flags);
	}

	/**
	 * @function LabelText
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} val
	 * @return {Undefined}
	 */
	static LabelText = function(label, val) {
		return __imgui_label_text(label, val);
	}

	/**
	 * @function ListBox
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {undefined}
	 */
	static ListBox = function() {
		return __imgui_list_box();
	}

	/**
	 * @function LoadIniSettingsFromDisk
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call after CreateContext() and before the first call to NewFrame(). NewFrame() automatically calls LoadIniSettingsFromDisk(io.IniFilename).
	 *
	 * @param {String} [ini_filename=undefined]
	 * @return {Undefined}
	 */
	static LoadIniSettingsFromDisk = function(ini_filename="undefined") {
		return __imgui_load_ini_settings_from_disk(ini_filename);
	}

	/**
	 * @function LoadIniSettingsFromMemory
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call after CreateContext() and before the first call to NewFrame() to provide .ini data from your own data source.
	 *
	 * @param {String} [ini_data=undefined]
	 * @return {Undefined}
	 */
	static LoadIniSettingsFromMemory = function(ini_data="undefined") {
		return __imgui_load_ini_settings_from_memory(ini_data);
	}

	/**
	 * @function LogButtons
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * helper to display buttons for logging to tty/file/clipboard
	 *
	 * @return {Undefined}
	 */
	static LogButtons = function() {
		return __imgui_log_buttons();
	}

	/**
	 * @function LogFinish
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * stop logging (close file, etc.)
	 *
	 * @return {Undefined}
	 */
	static LogFinish = function() {
		return __imgui_log_finish();
	}

	/**
	 * @function LogText
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} text
	 * @return {Undefined}
	 */
	static LogText = function(text) {
		return __imgui_log_text(text);
	}

	/**
	 * @function LogToClipboard
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * start logging to OS clipboard
	 *
	 * @param {Real} [auto_open_depth=-1]
	 * @return {Undefined}
	 */
	static LogToClipboard = function(auto_open_depth=-1) {
		return __imgui_log_to_clipboard(auto_open_depth);
	}

	/**
	 * @function LogToFile
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * start logging to file
	 *
	 * @param {Real} [auto_open_depth=-1]
	 * @param {Any} [filename=undefined]
	 * @return {Undefined}
	 */
	static LogToFile = function(auto_open_depth=-1, filename=undefined) {
		return __imgui_log_to_file(auto_open_depth, filename);
	}

	/**
	 * @function LogToTTY
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} [auto_open_depth=-1]
	 * @return {Undefined}
	 */
	static LogToTTY = function(auto_open_depth=-1) {
		return __imgui_log_to_tty(auto_open_depth);
	}

	/**
	 * @function MemoryEditorDrawContents
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} buffer
	 * @param {Real} [offset=0]
	 * @param {Real} [size=buffer_get_size⌊buffer⌉]
	 * @return {Undefined}
	 */
	static MemoryEditorDrawContents = function(buffer, offset=0, size=buffer_get_size(buffer)) {
		return __imgui_memory_editor_contents(buffer, offset, size);
	}

	/**
	 * @function MemoryEditorShowWindow
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} title
	 * @param {Real} buffer
	 * @param {Real} [offset=0]
	 * @param {Real} [size=buffer_get_size⌊buffer⌉]
	 * @return {Undefined}
	 */
	static MemoryEditorShowWindow = function(title, buffer, offset=0, size=buffer_get_size(buffer)) {
		return __imgui_memory_editor_window(title, buffer, offset, size);
	}

	/**
	 * @function MenuItem
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return true when activated.
	 *
	 * @param {String} label
	 * @param {String} [shortcut=]
	 * @param {Bool} [selected=undefined]
	 * @param {Bool} [enabled=true]
	 * @param {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
	 * @return {Real}
	 */
	static MenuItem = function(label, shortcut="", selected=undefined, enabled=true, mask=ImGuiReturnMask.Return) {
		return __imgui_menu_item(label, shortcut, selected, enabled, mask);
	}

	/**
	 * @function NewLine
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * undo a SameLine() or force a new line when in a horizontal-layout context.
	 *
	 * @return {Undefined}
	 */
	static NewLine = function() {
		return __imgui_new_line();
	}

	/**
	 * @function NextColumn
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * next column, defaults to current row or next row if the current row is finished
	 *
	 * @return {Undefined}
	 */
	static NextColumn = function() {
		return __imgui_next_column();
	}

	/**
	 * @function OpenPopup
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call to mark popup as open (don't call every frame!).
	 *
	 * @param {String} str_id
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.None]
	 * @return {Undefined}
	 */
	static OpenPopup = function(str_id, flags=ImGuiPopupFlags.None) {
		return __imgui_open_popup(str_id, flags);
	}

	/**
	 * @function OpenPopupOnItemClick
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * helper to open popup when clicked on last item. Default to ImGuiPopupFlags_MouseButtonRight == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
	 *
	 * @param {String} [str_id=undefined]
	 * @param {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
	 * @return {Undefined}
	 */
	static OpenPopupOnItemClick = function(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
		return __imgui_open_popup_on_item_click(str_id, flags);
	}

	/**
	 * @function PlotHistogram
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} values
	 * @param {Real} [values_offset=0]
	 * @param {String} [overlay_text=]
	 * @param {Real} [scale_min=0]
	 * @param {Real} [scale_max=0]
	 * @param {Real} [graph_width=0]
	 * @param {Real} [graph_height=0]
	 * @return {Undefined}
	 */
	static PlotHistogram = function(label, values, values_offset=0, overlay_text="", scale_min=0, scale_max=0, graph_width=0, graph_height=0) {
		return __imgui_plot_histogram(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height, array_length(values));
	}

	/**
	 * @function PlotLines
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} values
	 * @param {Real} [values_offset=0]
	 * @param {String} [overlay_text=]
	 * @param {Real} [scale_min=0]
	 * @param {Real} [scale_max=0]
	 * @param {Real} [graph_width=0]
	 * @param {Real} [graph_height=0]
	 * @return {Undefined}
	 */
	static PlotLines = function(label, values, values_offset=0, overlay_text="", scale_min=0, scale_max=0, graph_width=0, graph_height=0) {
		return __imgui_plot_lines(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height, array_length(values));
	}

	/**
	 * @function PopAllowKeyboardFocus
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static PopAllowKeyboardFocus = function() {
		return __imgui_pop_allow_keyboard_focus();
	}

	/**
	 * @function PopButtonRepeat
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static PopButtonRepeat = function() {
		return __imgui_pop_button_repeat();
	}

	/**
	 * @function PopClipRect
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Focus, Activation
	 *
	 * @return {Undefined}
	 */
	static PopClipRect = function() {
		return __imgui_pop_clip_rect();
	}

	/**
	 * @function PopFont
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static PopFont = function() {
		return __imgui_pop_font();
	}

	/**
	 * @function PopID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static PopID = function() {
		return __imgui_pop_id();
	}

	/**
	 * @function PopItemFlag
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Parameters stacks (current window)
	 *
	 * @return {Undefined}
	 */
	static PopItemFlag = function() {
		return __imgui_pop_item_flag();
	}

	/**
	 * @function PopItemWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {Undefined}
	 */
	static PopItemWidth = function() {
		return __imgui_pop_item_width();
	}

	/**
	 * @function PopStyleColor
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} [count=1]
	 * @return {Undefined}
	 */
	static PopStyleColor = function(count=1) {
		return __imgui_pop_style_color(count);
	}

	/**
	 * @function PopStyleVar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} [count=1]
	 * @return {Undefined}
	 */
	static PopStyleVar = function(count=1) {
		return __imgui_pop_style_var(count);
	}

	/**
	 * @function PopTextWrapPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Style read access
	 *
	 * @return {Undefined}
	 */
	static PopTextWrapPos = function() {
		return __imgui_pop_text_wrap_pos();
	}

	/**
	 * @function ProgressBar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} _frac
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @param {String} [overlay=]
	 * @return {Undefined}
	 */
	static ProgressBar = function(_frac, width=0, height=0, overlay="") {
		return __imgui_progress_bar(_frac, width, height, overlay);
	}

	/**
	 * @function PushAllowKeyboardFocus
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} allow_keyboard_focus
	 * @return {Undefined}
	 */
	static PushAllowKeyboardFocus = function(allow_keyboard_focus) {
		return __imgui_push_allow_keyboard_focus(allow_keyboard_focus);
	}

	/**
	 * @function PushButtonRepeat
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} _repeat
	 * @return {Undefined}
	 */
	static PushButtonRepeat = function(_repeat) {
		return __imgui_push_button_repeat(_repeat);
	}

	/**
	 * @function PushClipRect
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} clip_min_x
	 * @param {Real} clip_min_y
	 * @param {Real} clip_max_x
	 * @param {Real} clip_max_y
	 * @param {Bool} intersect_with_current_clip_rect
	 * @return {Undefined}
	 */
	static PushClipRect = function(clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect) {
		return __imgui_push_clip_rect(clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect);
	}

	/**
	 * @function PushFont
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Use NULL as a shortcut to keep current font. Use 0.0f to keep current size.
	 *
	 * @param {Any} [_ptr=undefined]
	 * @return {Undefined}
	 */
	static PushFont = function(_ptr=undefined) {
		return __imgui_push_font(_ptr);
	}

	/**
	 * @function PushID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String|Real} _id
	 * @return {Undefined}
	 */
	static PushID = function(_id) {
		return __imgui_push_id(_id);
	}

	/**
	 * @function PushItemFlag
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * modify specified shared item flag, e.g. PushItemFlag(ImGuiItemFlags_NoTabStop, true)
	 *
	 * @param {ImGuiItemFlags} item_flag
	 * @param {Bool} enabled
	 * @return {Undefined}
	 */
	static PushItemFlag = function(item_flag, enabled) {
		return __imgui_push_item_flag(item_flag, enabled);
	}

	/**
	 * @function PushItemWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * push width of items for common large "item+label" widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -FLT_MIN always align width to the right side).
	 *
	 * @param {Real} item_width
	 * @return {Undefined}
	 */
	static PushItemWidth = function(item_width) {
		return __imgui_push_item_width(item_width);
	}

	/**
	 * @function PushStyleColor
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * modify a style color. always use this if you modify the style after NewFrame().
	 *
	 * @param {Real} idx
	 * @param {Real} col
	 * @param {Real} alpha
	 * @return {Undefined}
	 */
	static PushStyleColor = function(idx, col, alpha) {
		return __imgui_push_style_color(idx, col, alpha);
	}

	/**
	 * @function PushStyleVar
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * modify a style float variable. always use this if you modify the style after NewFrame()!
	 *
	 * @param {Real} idx
	 * @param {Real} val
	 * @param {Any} [val2=undefined]
	 * @return {Undefined}
	 */
	static PushStyleVar = function(idx, val, val2=undefined) {
		return __imgui_push_style_var(idx, val, val2);
	}

	/**
	 * @function PushStyleVarX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * modify X component of a style ImVec2 variable. "
	 *
	 * @param {Real} idx
	 * @param {Real} val_x
	 * @return {Undefined}
	 */
	static PushStyleVarX = function(idx, val_x) {
		return __imgui_push_style_var_x(idx, val_x);
	}

	/**
	 * @function PushStyleVarY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * modify Y component of a style ImVec2 variable. "
	 *
	 * @param {Real} idx
	 * @param {Real} val_y
	 * @return {Undefined}
	 */
	static PushStyleVarY = function(idx, val_y) {
		return __imgui_push_style_var_y(idx, val_y);
	}

	/**
	 * @function PushTextWrapPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * push word-wrapping position for Text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
	 *
	 * @param {Real} [wrap_local_pos_x=0]
	 * @return {Undefined}
	 */
	static PushTextWrapPos = function(wrap_local_pos_x=0) {
		return __imgui_push_text_wrap_pos(wrap_local_pos_x);
	}

	/**
	 * @function RadioButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * use with e.g. if (RadioButton("one", my_value==1)) { my_value = 1; }
	 *
	 * @param {String} label
	 * @param {Bool} active
	 * @return {Bool}
	 */
	static RadioButton = function(label, active) {
		return __imgui_radio_button(label, active);
	}

	/**
	 * @function ResetMouseDragDelta
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {ImGuiMouseButton} button
	 * @return {Undefined}
	 */
	static ResetMouseDragDelta = function(button) {
		return __imgui_reset_mouse_drag_delta(button);
	}

	/**
	 * @function SameLine
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * call between widgets or groups to layout them horizontally. X position given in window coordinates.
	 *
	 * @param {Real} [offset_from_start_x=0]
	 * @param {Real} [spacing=-1]
	 * @return {Undefined}
	 */
	static SameLine = function(offset_from_start_x=0, spacing=-1) {
		return __imgui_same_line(offset_from_start_x, spacing);
	}

	/**
	 * @function SaveIniSettingsToDisk
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * this is automatically called (if io.IniFilename is not empty) a few seconds after any modification that should be reflected in the .ini file (and also by DestroyContext).
	 *
	 * @param {String} [ini_filename=undefined]
	 * @return {Undefined}
	 */
	static SaveIniSettingsToDisk = function(ini_filename="undefined") {
		return __imgui_save_ini_settings_to_disk(ini_filename);
	}

	/**
	 * @function SaveIniSettingsToMemory
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return a zero-terminated string with the .ini data which you can save by your own mean. call when io.WantSaveIniSettings is set, then save data by your own mean and clear io.WantSaveIniSettings.
	 *
	 * @return {String}
	 */
	static SaveIniSettingsToMemory = function() {
		return __imgui_save_ini_settings_to_memory();
	}

	/**
	 * @function Selectable
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * "bool selected" carry the selection state (read-only). Selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
	 *
	 * @param {String} label
	 * @param {Bool} [selected=false]
	 * @param {Enum.ImGuiSelectableFlags} [flags=ImGuiSelectableFlags.None]
	 * @param {Real} [width=0]
	 * @param {Real} [height=0]
	 * @return {Bool}
	 */
	static Selectable = function(label, selected=false, flags=ImGuiSelectableFlags.None, width=0, height=0) {
		return __imgui_selectable(label, selected, flags, width, height);
	}

	/**
	 * @function SelectionStorageApplyRequests
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiSelectionBasicStorage} selection
	 * @param {ImGuiMultiSelectIO} ms_io
	 * @return {Undefined}
	 */
	static SelectionStorageApplyRequests = function(selection, ms_io) {
		return __imgui_selection_storage_apply_requests(selection, ms_io);
	}

	/**
	 * @function SelectionStorageContains
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiSelectionBasicStorage} selection
	 * @param {Real} idx
	 * @return {Bool}
	 */
	static SelectionStorageContains = function(selection, idx) {
		return __imgui_selection_storage_contains(selection, idx);
	}

	/**
	 * @function SelectionStorageSize
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {ImGuiSelectionBasicStorage} selection
	 * @param {Any} [value=undefined]
	 * @return {Real}
	 */
	static SelectionStorageSize = function(selection, value=undefined) {
		return __imgui_selection_storage_size(selection, value);
	}

	/**
	 * @function Separator
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
	 *
	 * @return {Undefined}
	 */
	static Separator = function() {
		return __imgui_separator();
	}

	/**
	 * @function SeparatorText
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * currently: formatted text with a horizontal line
	 *
	 * @param {String} label
	 * @return {Undefined}
	 */
	static SeparatorText = function(label) {
		return __imgui_separator_text(label);
	}

	/**
	 * @function SetColorEditOptions
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * initialize current options (generally on application startup) if you want to select a default format, picker type, etc. User will be able to change many settings, unless you pass the _NoOptions flag to your calls.
	 *
	 * @param {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
	 * @return {Undefined}
	 */
	static SetColorEditOptions = function(flags=ImGuiColorEditFlags.None) {
		return __imgui_set_color_edit_options(flags);
	}

	/**
	 * @function SetColumnOffset
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set position of column line (in pixels, from the left side of the contents region). pass -1 to use current column
	 *
	 * @param {Real} column_index
	 * @param {Real} offset_x
	 * @return {Undefined}
	 */
	static SetColumnOffset = function(column_index, offset_x) {
		return __imgui_set_column_offset(column_index, offset_x);
	}

	/**
	 * @function SetColumnWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set column width (in pixels). pass -1 to use current column
	 *
	 * @param {Real} column_index
	 * @param {Real} width
	 * @return {Undefined}
	 */
	static SetColumnWidth = function(column_index, width) {
		return __imgui_set_column_width(column_index, width);
	}

	/**
	 * @function SetCurrentContext
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Main
	 *
	 * @param {Pointer} ctx
	 * @return {Undefined}
	 */
	static SetCurrentContext = function(ctx) {
		return __imgui_set_current_context(ctx);
	}

	/**
	 * @function SetCursorPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [window-local] "
	 *
	 * @param {Real} local_x
	 * @param {Real} local_y
	 * @return {Undefined}
	 */
	static SetCursorPos = function(local_x, local_y) {
		return __imgui_set_cursor_pos(local_x, local_y);
	}

	/**
	 * @function SetCursorPosX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [window-local] "
	 *
	 * @param {Real} local_x
	 * @return {Undefined}
	 */
	static SetCursorPosX = function(local_x) {
		return __imgui_set_cursor_pos_x(local_x);
	}

	/**
	 * @function SetCursorPosY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * [window-local] "
	 *
	 * @param {Real} local_y
	 * @return {Undefined}
	 */
	static SetCursorPosY = function(local_y) {
		return __imgui_set_cursor_pos_y(local_y);
	}

	/**
	 * @function SetCursorScreenPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * cursor position, absolute coordinates. THIS IS YOUR BEST FRIEND.
	 *
	 * @param {Real} _x
	 * @param {Real} _y
	 * @return {Undefined}
	 */
	static SetCursorScreenPos = function(_x, _y) {
		return __imgui_set_cursor_screen_pos(_x, _y);
	}

	/**
	 * @function SetDragDropPayload
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * type is a user defined string of maximum 32 characters. Strings starting with '_' are reserved for dear imgui internal types. Data is copied and held by imgui. Return true when payload has been accepted.
	 *
	 * @param {String} type
	 * @param {Any} data
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Bool}
	 */
	static SetDragDropPayload = function(type, data, cond=ImGuiCond.None) {
		return __imgui_set_drag_drop_payload(type, data, cond);
	}

	/**
	 * @function SetItemDefaultFocus
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * make last item the default focused item of a newly appearing window.
	 *
	 * @return {Undefined}
	 */
	static SetItemDefaultFocus = function() {
		return __imgui_set_item_default_focus();
	}

	/**
	 * @function SetItemKeyOwner
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Set key owner to last item ID if it is hovered or active. Equivalent to 'if (IsItemHovered() || IsItemActive()) { SetKeyOwner(key, GetItemID());'.
	 *
	 * @param {ImGuiKey} key
	 * @param {ImGuiInputFlags} [flags=undefined]
	 * @return {Undefined}
	 */
	static SetItemKeyOwner = function(key, flags=undefined) {
		return __imgui_set_item_key_owner(key, flags);
	}

	/**
	 * @function SetItemTooltip
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} text
	 * @return {Undefined}
	 */
	static SetItemTooltip = function(text) {
		return __imgui_set_item_tooltip(text);
	}

	/**
	 * @function SetKeyboardFocusHere
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * focus keyboard on the next widget. Use positive 'offset' to access sub components of a multiple component widget. Use -1 to access previous widget.
	 *
	 * @param {Real} [offset=0]
	 * @return {Undefined}
	 */
	static SetKeyboardFocusHere = function(offset=0) {
		return __imgui_set_keyboard_focus_here(offset);
	}

	/**
	 * @function SetNextFrameWantCaptureKeyboard
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Override io.WantCaptureKeyboard flag next frame (said flag is left for your application to handle, typically when true it instructs your app to ignore inputs). e.g. force capture keyboard when your widget is being hovered. This is equivalent to setting "io.WantCaptureKeyboard = want_capture_keyboard"; after the next NewFrame() call.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Undefined}
	 */
	static SetNextFrameWantCaptureKeyboard = function(val=undefined) {
		return __imgui_set_next_frame_want_capture_keyboard(val);
	}

	/**
	 * @function SetNextFrameWantCaptureMouse
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Override io.WantCaptureMouse flag next frame (said flag is left for your application to handle, typical when true it instructs your app to ignore inputs). This is equivalent to setting "io.WantCaptureMouse = want_capture_mouse;" after the next NewFrame() call.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Undefined}
	 */
	static SetNextFrameWantCaptureMouse = function(val=undefined) {
		return __imgui_set_next_frame_want_capture_mouse(val);
	}

	/**
	 * @function SetNextItemAllowOverlap
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * allow next item to be overlapped by a subsequent item. Useful with invisible buttons, selectable, treenode covering an area where subsequent items may need to be added. Note that both Selectable() and TreeNode() have dedicated flags doing this.
	 *
	 * @return {Undefined}
	 */
	static SetNextItemAllowOverlap = function() {
		return __imgui_set_next_item_allow_overlap();
	}

	/**
	 * @function SetNextItemOpen
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next TreeNode/CollapsingHeader open state.
	 *
	 * @param {Bool} is_open
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetNextItemOpen = function(is_open, cond=ImGuiCond.None) {
		return __imgui_set_next_item_open(is_open, cond);
	}

	/**
	 * @function SetNextItemSelectionUserData
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {Real} idx
	 * @return {undefined}
	 */
	static SetNextItemSelectionUserData = function(idx) {
		return __imgui_set_next_item_selection_user_data(idx);
	}

	/**
	 * @function SetNextItemShortcut
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Inputs Utilities: Key/Input Ownership [BETA]
	 *
	 * @param {ImGuiKeyChord} key_chord
	 * @param {ImGuiInputFlags} flags
	 * @return {Undefined}
	 */
	static SetNextItemShortcut = function(key_chord, flags) {
		return __imgui_set_next_item_shortcut(key_chord, flags);
	}

	/**
	 * @function SetNextItemWidth
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set width of the _next_ common large "item+label" widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -FLT_MIN always align width to the right side)
	 *
	 * @param {Real} item_width
	 * @return {Undefined}
	 */
	static SetNextItemWidth = function(item_width) {
		return __imgui_set_next_item_width(item_width);
	}

	/**
	 * @function SetNextWindowBgAlpha
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window background color alpha. helper to easily override the Alpha component of ImGuiCol_WindowBg/ChildBg/PopupBg. you may also use ImGuiWindowFlags_NoBackground.
	 *
	 * @param {Real} alpha
	 * @return {Undefined}
	 */
	static SetNextWindowBgAlpha = function(alpha) {
		return __imgui_set_next_window_bg_alpha(alpha);
	}

	/**
	 * @function SetNextWindowClass
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
	 *
	 * @param {ImGuiWindowClass} window_class
	 * @return {Undefined}
	 */
	static SetNextWindowClass = function(window_class) {
		return __imgui_set_next_window_class(window_class);
	}

	/**
	 * @function SetNextWindowCollapsed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window collapsed state. call before Begin()
	 *
	 * @param {Bool} collapsed
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetNextWindowCollapsed = function(collapsed, cond=ImGuiCond.None) {
		return __imgui_set_next_window_collapsed(collapsed, cond);
	}

	/**
	 * @function SetNextWindowContentSize
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window content size (~ scrollable client area, which enforce the range of scrollbars). Not including window decorations (title bar, menu bar, etc.) nor WindowPadding. set an axis to 0.0f to leave it automatic. call before Begin()
	 *
	 * @param {Real} width
	 * @param {Real} height
	 * @return {Undefined}
	 */
	static SetNextWindowContentSize = function(width, height) {
		return __imgui_set_next_window_content_size(width, height);
	}

	/**
	 * @function SetNextWindowDockID
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} dock_id
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetNextWindowDockID = function(dock_id, cond=ImGuiCond.None) {
		return __imgui_set_next_window_dock_id(dock_id, cond);
	}

	/**
	 * @function SetNextWindowFocus
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window to be focused / top-most. call before Begin()
	 *
	 * @return {Undefined}
	 */
	static SetNextWindowFocus = function() {
		return __imgui_set_next_window_focus();
	}

	/**
	 * @function SetNextWindowPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window position. call before Begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
	 *
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @param {Real} [pivot_x=0]
	 * @param {Real} [pivot_y=0]
	 * @return {Undefined}
	 */
	static SetNextWindowPos = function(_x, _y, cond=ImGuiCond.None, pivot_x=0, pivot_y=0) {
		return __imgui_set_next_window_pos(_x, _y, cond, pivot_x, pivot_y);
	}

	/**
	 * @function SetNextWindowScroll
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window scrolling value (use < 0.0f to not affect a given axis).
	 *
	 * @param {Real} scroll_x
	 * @param {Real} scroll_y
	 * @return {Undefined}
	 */
	static SetNextWindowScroll = function(scroll_x, scroll_y) {
		return __imgui_set_next_window_scroll(scroll_x, scroll_y);
	}

	/**
	 * @function SetNextWindowSize
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window size. set axis to 0.0f to force an auto-fit on this axis. call before Begin()
	 *
	 * @param {Real} width
	 * @param {Real} height
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetNextWindowSize = function(width, height, cond=ImGuiCond.None) {
		return __imgui_set_next_window_size(width, height, cond);
	}

	/**
	 * @function SetNextWindowSizeConstraints
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window size limits. use 0.0f or FLT_MAX if you don't want limits. Use -1 for both min and max of same axis to preserve current size (which itself is a constraint). Use callback to apply non-trivial programmatic constraints.
	 *
	 * @param {Real} min_width
	 * @param {Real} min_height
	 * @param {Real} max_width
	 * @param {Real} max_height
	 * @return {Undefined}
	 */
	static SetNextWindowSizeConstraints = function(min_width, min_height, max_width, max_height) {
		return __imgui_set_next_window_size_constraints(min_width, min_height, max_width, max_height);
	}

	/**
	 * @function SetNextWindowViewport
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set next window viewport
	 *
	 * @param {Real} _id
	 * @return {Undefined}
	 */
	static SetNextWindowViewport = function(_id) {
		return __imgui_set_next_window_viewport(_id);
	}

	/**
	 * @function SetScrollFromPosX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * adjust scrolling amount to make given position visible. Generally GetCursorStartPos() + offset to compute a valid position.
	 *
	 * @param {Real} local_x
	 * @param {Real} [center_x_ratio=0.5]
	 * @return {Undefined}
	 */
	static SetScrollFromPosX = function(local_x, center_x_ratio=0.5) {
		return __imgui_set_scroll_from_pos_x(local_x, center_x_ratio);
	}

	/**
	 * @function SetScrollFromPosY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * adjust scrolling amount to make given position visible. Generally GetCursorStartPos() + offset to compute a valid position.
	 *
	 * @param {Real} local_y
	 * @param {Real} [center_y_ratio=0.5]
	 * @return {Undefined}
	 */
	static SetScrollFromPosY = function(local_y, center_y_ratio=0.5) {
		return __imgui_set_scroll_from_pos_y(local_y, center_y_ratio);
	}

	/**
	 * @function SetScrollHereX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. When using to make a "default/current item" visible, consider using SetItemDefaultFocus() instead.
	 *
	 * @param {Real} [center_x_ratio=0.5]
	 * @return {Undefined}
	 */
	static SetScrollHereX = function(center_x_ratio=0.5) {
		return __imgui_set_scroll_here_x(center_x_ratio);
	}

	/**
	 * @function SetScrollHereY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. When using to make a "default/current item" visible, consider using SetItemDefaultFocus() instead.
	 *
	 * @param {Real} [center_y_ratio=0.5]
	 * @return {Undefined}
	 */
	static SetScrollHereY = function(center_y_ratio=0.5) {
		return __imgui_set_scroll_here_y(center_y_ratio);
	}

	/**
	 * @function SetScrollX
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set scrolling amount [0 .. GetScrollMaxX()]
	 *
	 * @param {Real} scroll_x
	 * @return {Undefined}
	 */
	static SetScrollX = function(scroll_x) {
		return __imgui_set_scroll_x(scroll_x);
	}

	/**
	 * @function SetScrollY
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * set scrolling amount [0 .. GetScrollMaxY()]
	 *
	 * @param {Real} scroll_y
	 * @return {Undefined}
	 */
	static SetScrollY = function(scroll_y) {
		return __imgui_set_scroll_y(scroll_y);
	}

	/**
	 * @function SetStyleColor
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} idx
	 * @param {Real} col
	 * @param {Real} alpha
	 * @return {Undefined}
	 */
	static SetStyleColor = function(idx, col, alpha) {
		return __imgui_set_style_color(idx, col, alpha);
	}

	/**
	 * @function SetStyleVar
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} idx
	 * @param {Any} val
	 * @param {Any} [val2=undefined]
	 * @return {Undefined}
	 */
	static SetStyleVar = function(idx, val, val2=undefined) {
		return __imgui_set_style_var(idx, val, val2);
	}

	/**
	 * @function SetTabItemClosed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * notify TabBar or Docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). For tab-bar: call after BeginTabBar() and before Tab submissions. Otherwise call with a window name.
	 *
	 * @param {String} tab_or_docked_window_label
	 * @return {Undefined}
	 */
	static SetTabItemClosed = function(tab_or_docked_window_label) {
		return __imgui_set_tab_item_closed(tab_or_docked_window_label);
	}

	/**
	 * @function SetTooltip
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @return {Undefined}
	 */
	static SetTooltip = function(val) {
		return __imgui_set_tooltip(val);
	}

	/**
	 * @function SetWindowCollapsed
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * (not recommended) set current window collapsed state. prefer using SetNextWindowCollapsed().
	 *
	 * @param {String} [name=]
	 * @param {Bool} collapsed
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetWindowCollapsed = function(name="", collapsed, cond=ImGuiCond.None) {
		return __imgui_set_window_collapsed(name, collapsed, cond);
	}

	/**
	 * @function SetWindowFocus
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * (not recommended) set current window to be focused / top-most. prefer using SetNextWindowFocus().
	 *
	 * @param {String} [name=]
	 * @return {Undefined}
	 */
	static SetWindowFocus = function(name="") {
		return __imgui_set_window_focus(name);
	}

	/**
	 * @function SetWindowFontScale
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * Set font scale factor for current window. Prefer using PushFont(NULL, style.FontSizeBase * factor) or use style.FontScaleMain to scale all windows.
	 *
	 * @param {Real} scale
	 * @return {Undefined}
	 */
	static SetWindowFontScale = function(scale) {
		return __imgui_set_window_font_scale(scale);
	}

	/**
	 * @function SetWindowPos
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * (not recommended) set current window position - call within Begin()/End(). prefer using SetNextWindowPos(), as this may incur tearing and side-effects.
	 *
	 * @param {String} [name=]
	 * @param {Real} _x
	 * @param {Real} _y
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetWindowPos = function(name="", _x, _y, cond=ImGuiCond.None) {
		return __imgui_set_window_pos(name, _x, _y, cond);
	}

	/**
	 * @function SetWindowSize
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * (not recommended) set current window size - call within Begin()/End(). set to ImVec2(0, 0) to force an auto-fit. prefer using SetNextWindowSize(), as this may incur tearing and minor side-effects.
	 *
	 * @param {String} [name=]
	 * @param {Real} width
	 * @param {Real} height
	 * @param {Enum.ImGuiCond} [cond=ImGuiCond.None]
	 * @return {Undefined}
	 */
	static SetWindowSize = function(name="", width, height, cond=ImGuiCond.None) {
		return __imgui_set_window_size(name, width, height, cond);
	}

	/**
	 * @function Shortcut
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {ImGuiKeyChord} key_chord
	 * @param {ImGuiInputFlags} flags
	 * @param {ImGuiID} [owner_id=undefined]
	 * @return {Bool}
	 */
	static Shortcut = function(key_chord, flags, owner_id=undefined) {
		return __imgui_shortcut(key_chord, flags, owner_id);
	}

	/**
	 * @function ShowAboutWindow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create About window. display Dear ImGui version, credits and build/system information.
	 *
	 * @param {Bool} [open=undefined]
	 * @return {Bool}
	 */
	static ShowAboutWindow = function(open=undefined) {
		return __imgui_show_about_window(open);
	}

	/**
	 * @function ShowDebugLogWindow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create Debug Log window. display a simplified log of important dear imgui events.
	 *
	 * @param {Bool} [open=undefined]
	 * @return {Bool}
	 */
	static ShowDebugLogWindow = function(open=undefined) {
		return __imgui_show_debug_log_window(open);
	}

	/**
	 * @function ShowDemoWindow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create Demo window. demonstrate most ImGui features. call this to learn about the library! try to make it always available in your application!
	 *
	 * @param {Bool} [open=undefined]
	 * @return {Bool}
	 */
	static ShowDemoWindow = function(open=undefined) {
		return __imgui_show_demo_window(open);
	}

	/**
	 * @function ShowFontSelector
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add font selector block (not a window), essentially a combo listing the loaded fonts.
	 *
	 * @param {String} label
	 * @return {Undefined}
	 */
	static ShowFontSelector = function(label) {
		return __imgui_show_font_selector(label);
	}

	/**
	 * @function ShowIDStackToolWindow
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [open=undefined]
	 * @return {Bool}
	 */
	static ShowIDStackToolWindow = function(open=undefined) {
		return __imgui_show_stack_tool_window(open);
	}

	/**
	 * @function ShowMetricsWindow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create Metrics/Debugger window. display Dear ImGui internals: windows, draw commands, various internal state, etc.
	 *
	 * @param {Bool} [open=undefined]
	 * @return {Bool}
	 */
	static ShowMetricsWindow = function(open=undefined) {
		return __imgui_show_metrics_window(open);
	}

	/**
	 * @function ShowStyleEditor
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add style editor block (not a window). you can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it uses the default style)
	 *
	 * @return {Undefined}
	 */
	static ShowStyleEditor = function() {
		return __imgui_show_style_editor();
	}

	/**
	 * @function ShowStyleSelector
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add style selector block (not a window), essentially a combo listing the default styles.
	 *
	 * @param {String} label
	 * @return {Bool}
	 */
	static ShowStyleSelector = function(label) {
		return __imgui_show_style_selector(label);
	}

	/**
	 * @function ShowUserGuide
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add basic help/info block (not a window): how to manipulate ImGui as an end-user (mouse/keyboard controls).
	 *
	 * @return {Undefined}
	 */
	static ShowUserGuide = function() {
		return __imgui_show_user_guide();
	}

	/**
	 * @function SliderAngle
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} v_rad
	 * @param {Real} [v_degrees_min=0]
	 * @param {Real} v_degrees_max
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static SliderAngle = function(label, v_rad, v_degrees_min=0, v_degrees_max, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_angle(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
	}

	/**
	 * @function SliderFloat
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display.
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static SliderFloat = function(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_float(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderFloat2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderFloat2 = function(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_float2(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderFloat3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderFloat3 = function(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_float3(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderFloat4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderFloat4 = function(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_float4(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderFloatN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_speed=1]
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderFloatN = function(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_float_n(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
	}

	/**
	 * @function SliderInt
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static SliderInt = function(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_int(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderInt2
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderInt2 = function(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_int2(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderInt3
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderInt3 = function(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_int3(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderInt4
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderInt4 = function(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_int4(label, v, v_min, v_max, format, flags);
	}

	/**
	 * @function SliderIntN
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Array} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Bool}
	 */
	static SliderIntN = function(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_slider_int_n(label, v, v_min, v_max, format, flags, array_length(v));
	}

	/**
	 * @function SmallButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * button with (FramePadding.y == 0) to easily embed within text
	 *
	 * @param {String} label
	 * @return {Bool}
	 */
	static SmallButton = function(label) {
		return __imgui_small_button(label);
	}

	/**
	 * @function Spacing
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * add vertical spacing.
	 *
	 * @return {Undefined}
	 */
	static Spacing = function() {
		return __imgui_spacing();
	}

	/**
	 * @function StyleColorsClassic
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * classic imgui style
	 *
	 * @return {Undefined}
	 */
	static StyleColorsClassic = function() {
		return __imgui_style_colors_classic();
	}

	/**
	 * @function StyleColorsDark
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * new, recommended style (default)
	 *
	 * @return {Undefined}
	 */
	static StyleColorsDark = function() {
		return __imgui_style_colors_dark();
	}

	/**
	 * @function StyleColorsLight
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * best used with borders and a custom, thicker font
	 *
	 * @return {Undefined}
	 */
	static StyleColorsLight = function() {
		return __imgui_style_colors_light();
	}

	/**
	 * @function Surface
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Real} surface
	 * @param {Real} [color=c_white]
	 * @param {Real} [alpha=1]
	 * @param {Real} [width=surface_get_width⌊surface⌉]
	 * @param {Real} [height=surface_get_height⌊surface⌉]
	 * @return {Undefined}
	 */
	static Surface = function(surface, color=c_white, alpha=1, width=surface_get_width(surface), height=surface_get_height(surface)) {
		var _tex = surface_get_texture(surface); if (!(ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) {texture_set_stage(0, _tex);};
		return __imgui_surface(surface, color, alpha, width, height, texture_get_uvs(_tex));
	}

	/**
	 * @function TabItemButton
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * create a Tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
	 *
	 * @param {String} label
	 * @param {Enum.ImGuiTabItemFlags} [flags=ImGuiTabItemFlags.None]
	 * @return {Bool}
	 */
	static TabItemButton = function(label, flags=ImGuiTabItemFlags.None) {
		return __imgui_tab_item_button(label, flags);
	}

	/**
	 * @function TableAngledHeadersRow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * submit a row with angled headers for every column with the ImGuiTableColumnFlags_AngledHeader flag. MUST BE FIRST ROW.
	 *
	 * @return {Undefined}
	 */
	static TableAngledHeadersRow = function() {
		return __imgui_table_angled_headers_row();
	}

	/**
	 * @function TableGetColumnCount
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return number of columns (value passed to BeginTable)
	 *
	 * @return {Real}
	 */
	static TableGetColumnCount = function() {
		return __imgui_table_get_column_count();
	}

	/**
	 * @function TableGetColumnFlags
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return column flags so you can query their Enabled/Visible/Sorted/Hovered status flags. Pass -1 to use current column.
	 *
	 * @param {Real} [column_n=-1]
	 * @return {Real}
	 */
	static TableGetColumnFlags = function(column_n=-1) {
		return __imgui_table_get_column_flags(column_n);
	}

	/**
	 * @function TableGetColumnIndex
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return current column index.
	 *
	 * @return {Real}
	 */
	static TableGetColumnIndex = function() {
		return __imgui_table_get_column_index();
	}

	/**
	 * @function TableGetColumnName
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return "" if column didn't have a name declared by TableSetupColumn(). Pass -1 to use current column.
	 *
	 * @param {Real} [column_n=-1]
	 * @return {String}
	 */
	static TableGetColumnName = function(column_n=-1) {
		return __imgui_table_get_column_name(column_n);
	}

	/**
	 * @function TableGetHoveredColumn
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return hovered column. return -1 when table is not hovered. return columns_count if the unused space at the right of visible columns is hovered. Can also use (TableGetColumnFlags() & ImGuiTableColumnFlags_IsHovered) instead.
	 *
	 * @return {Real}
	 */
	static TableGetHoveredColumn = function() {
		return __imgui_table_get_hovered_column();
	}

	/**
	 * @function TableGetRowIndex
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * return current row index (header rows are accounted for)
	 *
	 * @return {Real}
	 */
	static TableGetRowIndex = function() {
		return __imgui_table_get_row_index();
	}

	/**
	 * @function TableHeader
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * submit one header cell manually (rarely used)
	 *
	 * @param {String} label
	 * @return {Undefined}
	 */
	static TableHeader = function(label) {
		return __imgui_table_header(label);
	}

	/**
	 * @function TableHeadersRow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * submit a row with headers cells based on data provided to TableSetupColumn() + submit context menu
	 *
	 * @return {Undefined}
	 */
	static TableHeadersRow = function() {
		return __imgui_table_headers_row();
	}

	/**
	 * @function TableNextColumn
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * append into the next column (or first column of next row if currently in last column). Return true when column is visible.
	 *
	 * @return {Bool}
	 */
	static TableNextColumn = function() {
		return __imgui_table_next_column();
	}

	/**
	 * @function TableNextRow
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * append into the first cell of a new row.
	 *
	 * @param {Enum.ImGuiTableRowFlags} [row_flags=ImGuiTableRowFlags.None]
	 * @param {Real} [min_row_height=0]
	 * @return {Undefined}
	 */
	static TableNextRow = function(row_flags=ImGuiTableRowFlags.None, min_row_height=0) {
		return __imgui_table_next_row(row_flags, min_row_height);
	}

	/**
	 * @function TableSetBgColor
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * change the color of a cell, row, or column. See ImGuiTableBgTarget_ flags for details.
	 *
	 * @param {Real} target
	 * @param {Real} col
	 * @param {Real} [column_n=-1]
	 * @return {Undefined}
	 */
	static TableSetBgColor = function(target, col, column_n=-1) {
		return __imgui_table_set_bg_color(target, col, column_n);
	}

	/**
	 * @function TableSetColumnEnabled
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * change user accessible enabled/disabled state of a column. Set to false to hide the column. User can use the context menu to change this themselves (right-click in headers, or right-click in columns body with ImGuiTableFlags_ContextMenuInBody)
	 *
	 * @param {Real} column_n
	 * @param {Bool} v
	 * @return {Undefined}
	 */
	static TableSetColumnEnabled = function(column_n, v) {
		return __imgui_table_set_column_enabled(column_n, v);
	}

	/**
	 * @function TableSetColumnIndex
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * append into the specified column. Return true when column is visible.
	 *
	 * @param {Real} column_n
	 * @return {Bool}
	 */
	static TableSetColumnIndex = function(column_n) {
		return __imgui_table_set_column_index(column_n);
	}

	/**
	 * @function TableSetupColumn
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Enum.ImGuiTableColumnFlags} [flags=ImGuiTableColumnFlags.None]
	 * @param {Real} [user_id=0]
	 * @return {Undefined}
	 */
	static TableSetupColumn = function(label, flags=ImGuiTableColumnFlags.None, user_id=0) {
		return __imgui_table_setup_column(label, flags, user_id);
	}

	/**
	 * @function TableSetupScrollFreeze
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * lock columns/rows so they stay visible when scrolled.
	 *
	 * @param {Real} cols
	 * @param {Real} rows
	 * @return {Undefined}
	 */
	static TableSetupScrollFreeze = function(cols, rows) {
		return __imgui_table_setup_scroll_freeze(cols, rows);
	}

	/**
	 * @function Text
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @return {Undefined}
	 */
	static Text = function(val) {
		return __imgui_text(val);
	}

	/**
	 * @function TextColored
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @param {Real} color
	 * @param {Real} [alpha=1]
	 * @return {Undefined}
	 */
	static TextColored = function(val, color, alpha=1) {
		return __imgui_text_colored(val, color, alpha);
	}

	/**
	 * @function TextDisabled
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @return {Undefined}
	 */
	static TextDisabled = function(val) {
		return __imgui_text_disabled(val);
	}

	/**
	 * @function TextLink
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * hyperlink text button, return true when clicked
	 *
	 * @param {String} label
	 * @return {Undefined}
	 */
	static TextLink = function(label) {
		return __imgui_text_link(label);
	}

	/**
	 * @function TextLinkOpenURL
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {String} url
	 * @return {Undefined}
	 */
	static TextLinkOpenURL = function(label, url) {
		return __imgui_text_link_open_url(label, url);
	}

	/**
	 * @function TextUnformatted
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * raw text without formatting. Roughly equivalent to Text("%s", text) but: A) doesn't require null terminated string if 'text_end' is specified, B) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
	 *
	 * @param {String} text
	 * @return {Undefined}
	 */
	static TextUnformatted = function(text) {
		return __imgui_text_unformatted(text);
	}

	/**
	 * @function TextWrapped
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} val
	 * @return {Undefined}
	 */
	static TextWrapped = function(val) {
		return __imgui_text_wrapped(val);
	}

	/**
	 * @function TreeNode
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @return {Bool}
	 */
	static TreeNode = function(label) {
		return __imgui_tree_node(label);
	}

	/**
	 * @function TreeNodeEx
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Enum.ImGuiTreeNodeFlags} [flags=ImGuiTreeNodeFlags.None]
	 * @return {Bool}
	 */
	static TreeNodeEx = function(label, flags=ImGuiTreeNodeFlags.None) {
		return __imgui_tree_node_ex(label, flags);
	}

	/**
	 * @function TreePop
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ Unindent()+PopID()
	 *
	 * @return {Undefined}
	 */
	static TreePop = function() {
		return __imgui_tree_pop();
	}

	/**
	 * @function TreePush
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * ~ Indent()+PushID(). Already called by TreeNode() when returning true, but you can call TreePush/TreePop yourself if desired.
	 *
	 * @param {String} str_id
	 * @return {Undefined}
	 */
	static TreePush = function(str_id) {
		return __imgui_tree_push(str_id);
	}

	/**
	 * @function Unindent
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 * move content position back to the left, by indent_w, or style.IndentSpacing if indent_w <= 0
	 *
	 * @param {Real} [indent_w=0]
	 * @return {Undefined}
	 */
	static Unindent = function(indent_w=0) {
		return __imgui_unindent(indent_w);
	}

	/**
	 * @function Value
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @return {undefined}
	 */
	static Value = function() {
		return __imgui_value();
	}

	/**
	 * @function VSliderFloat
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} width
	 * @param {Real} height
	 * @param {Real} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%.3f]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static VSliderFloat = function(label, width, height, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
		return __imgui_v_slider_float(label, width, height, v, v_min, v_max, format, flags);
	}

	/**
	 * @function VSliderInt
	 * @context ImGui
	 * @desc ImGM wrapper for `ImGui`.
	 *
	 * @param {String} label
	 * @param {Real} width
	 * @param {Real} height
	 * @param {Real} v
	 * @param {Real} [v_min=0]
	 * @param {Real} [v_max=0]
	 * @param {String} [format=%d]
	 * @param {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
	 * @return {Real}
	 */
	static VSliderInt = function(label, width, height, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
		return __imgui_v_slider_int(label, width, height, v, v_min, v_max, format, flags);
	}

	/**
	 * @function WantKeyboardCapture
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Bool}
	 */
	static WantKeyboardCapture = function(val=undefined) {
		return __imgui_want_keyboard_capture(val);
	}

	/**
	 * @function WantMouseCapture
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Bool}
	 */
	static WantMouseCapture = function(val=undefined) {
		return __imgui_want_mouse_capture(val);
	}

	/**
	 * @function WantMouseCaptureUnlessPopupClose
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Bool}
	 */
	static WantMouseCaptureUnlessPopupClose = function(val=undefined) {
		return __imgui_want_mouse_unless_popup_close(val);
	}

	/**
	 * @function WantSaveIniSettings
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Bool}
	 */
	static WantSaveIniSettings = function(val=undefined) {
		return __imgui_want_save_ini_settings(val);
	}

	/**
	 * @function WantTextInput
	 * @context ImGui
	 * @desc ImGM custom wrapper for `ImGui`.
	 *
	 * @param {Bool} [val=undefined]
	 * @return {Bool}
	 */
	static WantTextInput = function(val=undefined) {
		return __imgui_want_text_input(val);
	}

	#endregion

	#region Enums

	/**
	 * @enum ImGuiWindowFlags
	 * @desc Flags for ImGui::Begin()
	 *
	 */
	enum ImGuiWindowFlags {
		None = 0,
		NoTitleBar = 1 << 0,
		NoResize = 1 << 1,
		NoMove = 1 << 2,
		NoScrollbar = 1 << 3,
		NoScrollWithMouse = 1 << 4,
		NoCollapse = 1 << 5,
		AlwaysAutoResize = 1 << 6,
		NoBackground = 1 << 7,
		NoSavedSettings = 1 << 8,
		NoMouseInputs = 1 << 9,
		MenuBar = 1 << 10,
		HorizontalScrollbar = 1 << 11,
		NoFocusOnAppearing = 1 << 12,
		NoBringToFrontOnFocus = 1 << 13,
		AlwaysVerticalScrollbar = 1 << 14,
		AlwaysHorizontalScrollbar = 1 << 15,
		NoNavInputs = 1 << 16,
		NoNavFocus = 1 << 17,
		UnsavedDocument = 1 << 18,
		NoDocking = 1 << 19,
		NoNav = ImGuiWindowFlags.NoNavInputs | ImGuiWindowFlags.NoNavFocus,
		NoDecoration = ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoCollapse,
		NoInputs = ImGuiWindowFlags.NoMouseInputs | ImGuiWindowFlags.NoNavInputs | ImGuiWindowFlags.NoNavFocus,
		DockNodeHost = 1 << 23,
		ChildWindow = 1 << 24,
		Tooltip = 1 << 25,
		Popup = 1 << 26,
		Modal = 1 << 27,
		ChildMenu = 1 << 28,
		NavFlattened = 1 << 29,
		AlwaysUseWindowPadding = 1 << 30,
	}

	/**
	 * @enum ImGuiChildFlags
	 * @desc Flags for ImGui::BeginChild()
	 *
	 */
	enum ImGuiChildFlags {
		None = 0,
		Borders = 1 << 0,
		AlwaysUseWindowPadding = 1 << 1,
		ResizeX = 1 << 2,
		ResizeY = 1 << 3,
		AutoResizeX = 1 << 4,
		AutoResizeY = 1 << 5,
		AlwaysAutoResize = 1 << 6,
		FrameStyle = 1 << 7,
		NavFlattened = 1 << 8,
		Border = ImGuiChildFlags.Borders,
	}

	/**
	 * @enum ImGuiItemFlags
	 * @desc Flags for ImGui::PushItemFlag()
	 *
	 */
	enum ImGuiItemFlags {
		None = 0,
		NoTabStop = 1 << 0,
		NoNav = 1 << 1,
		NoNavDefaultFocus = 1 << 2,
		ButtonRepeat = 1 << 3,
		AutoClosePopups = 1 << 4,
		AllowDuplicateId = 1 << 5,
	}

	/**
	 * @enum ImGuiInputTextFlags
	 * @desc Flags for ImGui::InputText()
	 *
	 */
	enum ImGuiInputTextFlags {
		None = 0,
		CharsDecimal = 1 << 0,
		CharsHexadecimal = 1 << 1,
		CharsScientific = 1 << 2,
		CharsUppercase = 1 << 3,
		CharsNoBlank = 1 << 4,
		AllowTabInput = 1 << 5,
		EnterReturnsTrue = 1 << 6,
		EscapeClearsAll = 1 << 7,
		CtrlEnterForNewLine = 1 << 8,
		ReadOnly = 1 << 9,
		Password = 1 << 10,
		AlwaysOverwrite = 1 << 11,
		AutoSelectAll = 1 << 12,
		ParseEmptyRefVal = 1 << 13,
		DisplayEmptyRefVal = 1 << 14,
		NoHorizontalScroll = 1 << 15,
		NoUndoRedo = 1 << 16,
		ElideLeft = 1 << 17,
		CallbackCompletion = 1 << 18,
		CallbackHistory = 1 << 19,
		CallbackAlways = 1 << 20,
		CallbackCharFilter = 1 << 21,
		CallbackResize = 1 << 22,
		CallbackEdit = 1 << 23,
	}

	/**
	 * @enum ImGuiTreeNodeFlags
	 * @desc Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
	 *
	 */
	enum ImGuiTreeNodeFlags {
		None = 0,
		Selected = 1 << 0,
		Framed = 1 << 1,
		AllowOverlap = 1 << 2,
		NoTreePushOnOpen = 1 << 3,
		NoAutoOpenOnLog = 1 << 4,
		DefaultOpen = 1 << 5,
		OpenOnDoubleClick = 1 << 6,
		OpenOnArrow = 1 << 7,
		Leaf = 1 << 8,
		Bullet = 1 << 9,
		FramePadding = 1 << 10,
		SpanAvailWidth = 1 << 11,
		SpanFullWidth = 1 << 12,
		SpanLabelWidth = 1 << 13,
		SpanAllColumns = 1 << 14,
		LabelSpanAllColumns = 1 << 15,
		NavLeftJumpsToParent = 1 << 17,
		CollapsingHeader = ImGuiTreeNodeFlags.Framed | ImGuiTreeNodeFlags.NoTreePushOnOpen | ImGuiTreeNodeFlags.NoAutoOpenOnLog,
		DrawLinesNone = 1 << 18,
		DrawLinesFull = 1 << 19,
		DrawLinesToNodes = 1 << 20,
		NavLeftJumpsBackHere = ImGuiTreeNodeFlags.NavLeftJumpsToParent,
		SpanTextWidth = ImGuiTreeNodeFlags.SpanLabelWidth,
		AllowItemOverlap = ImGuiTreeNodeFlags.AllowOverlap,
	}

	/**
	 * @enum ImGuiPopupFlags
	 * @desc Flags for OpenPopup*(), BeginPopupContext*(), IsPopupOpen() functions.
	 *
	 */
	enum ImGuiPopupFlags {
		None = 0,
		MouseButtonLeft = 0,
		MouseButtonRight = 1,
		MouseButtonMiddle = 2,
		MouseButtonMask_ = 0x1F,
		MouseButtonDefault_ = 1,
		NoReopen = 1 << 5,
		NoOpenOverExistingPopup = 1 << 7,
		NoOpenOverItems = 1 << 8,
		AnyPopupId = 1 << 10,
		AnyPopupLevel = 1 << 11,
		AnyPopup = ImGuiPopupFlags.AnyPopupId | ImGuiPopupFlags.AnyPopupLevel,
	}

	/**
	 * @enum ImGuiSelectableFlags
	 * @desc Flags for ImGui::Selectable()
	 *
	 */
	enum ImGuiSelectableFlags {
		None = 0,
		NoAutoClosePopups = 1 << 0,
		SpanAllColumns = 1 << 1,
		AllowDoubleClick = 1 << 2,
		Disabled = 1 << 3,
		AllowOverlap = 1 << 4,
		Highlight = 1 << 5,
		DontClosePopups = ImGuiSelectableFlags.NoAutoClosePopups,
		AllowItemOverlap = ImGuiSelectableFlags.AllowOverlap,
	}

	/**
	 * @enum ImGuiComboFlags
	 * @desc Flags for ImGui::BeginCombo()
	 *
	 */
	enum ImGuiComboFlags {
		None = 0,
		PopupAlignLeft = 1 << 0,
		HeightSmall = 1 << 1,
		HeightRegular = 1 << 2,
		HeightLarge = 1 << 3,
		HeightLargest = 1 << 4,
		NoArrowButton = 1 << 5,
		NoPreview = 1 << 6,
		WidthFitPreview = 1 << 7,
		HeightMask_ = ImGuiComboFlags.HeightSmall | ImGuiComboFlags.HeightRegular | ImGuiComboFlags.HeightLarge | ImGuiComboFlags.HeightLargest,
	}

	/**
	 * @enum ImGuiTabBarFlags
	 * @desc Flags for ImGui::BeginTabBar()
	 *
	 */
	enum ImGuiTabBarFlags {
		None = 0,
		Reorderable = 1 << 0,
		AutoSelectNewTabs = 1 << 1,
		TabListPopupButton = 1 << 2,
		NoCloseWithMiddleMouseButton = 1 << 3,
		NoTabListScrollingButtons = 1 << 4,
		NoTooltip = 1 << 5,
		DrawSelectedOverline = 1 << 6,
		FittingPolicyMixed = 1 << 7,
		FittingPolicyShrink = 1 << 8,
		FittingPolicyScroll = 1 << 9,
		FittingPolicyMask_ = ImGuiTabBarFlags.FittingPolicyMixed | ImGuiTabBarFlags.FittingPolicyShrink | ImGuiTabBarFlags.FittingPolicyScroll,
		FittingPolicyDefault_ = ImGuiTabBarFlags.FittingPolicyMixed,
		FittingPolicyResizeDown = ImGuiTabBarFlags.FittingPolicyShrink,
	}

	/**
	 * @enum ImGuiTabItemFlags
	 * @desc Flags for ImGui::BeginTabItem()
	 *
	 */
	enum ImGuiTabItemFlags {
		None = 0,
		UnsavedDocument = 1 << 0,
		SetSelected = 1 << 1,
		NoCloseWithMiddleMouseButton = 1 << 2,
		NoPushId = 1 << 3,
		NoTooltip = 1 << 4,
		NoReorder = 1 << 5,
		Leading = 1 << 6,
		Trailing = 1 << 7,
		NoAssumedClosure = 1 << 8,
	}

	/**
	 * @enum ImGuiFocusedFlags
	 * @desc Flags for ImGui::IsWindowFocused()
	 *
	 */
	enum ImGuiFocusedFlags {
		None = 0,
		ChildWindows = 1 << 0,
		RootWindow = 1 << 1,
		AnyWindow = 1 << 2,
		NoPopupHierarchy = 1 << 3,
		DockHierarchy = 1 << 4,
		RootAndChildWindows = ImGuiFocusedFlags.RootWindow | ImGuiFocusedFlags.ChildWindows,
	}

	/**
	 * @enum ImGuiHoveredFlags
	 * @desc Flags for ImGui::IsItemHovered(), ImGui::IsWindowHovered()
	 *
	 */
	enum ImGuiHoveredFlags {
		None = 0,
		ChildWindows = 1 << 0,
		RootWindow = 1 << 1,
		AnyWindow = 1 << 2,
		NoPopupHierarchy = 1 << 3,
		DockHierarchy = 1 << 4,
		AllowWhenBlockedByPopup = 1 << 5,
		AllowWhenBlockedByActiveItem = 1 << 7,
		AllowWhenOverlappedByItem = 1 << 8,
		AllowWhenOverlappedByWindow = 1 << 9,
		AllowWhenDisabled = 1 << 10,
		NoNavOverride = 1 << 11,
		AllowWhenOverlapped = ImGuiHoveredFlags.AllowWhenOverlappedByItem | ImGuiHoveredFlags.AllowWhenOverlappedByWindow,
		RectOnly = ImGuiHoveredFlags.AllowWhenBlockedByPopup | ImGuiHoveredFlags.AllowWhenBlockedByActiveItem | ImGuiHoveredFlags.AllowWhenOverlapped,
		RootAndChildWindows = ImGuiHoveredFlags.RootWindow | ImGuiHoveredFlags.ChildWindows,
		ForTooltip = 1 << 12,
		Stationary = 1 << 13,
		DelayNone = 1 << 14,
		DelayShort = 1 << 15,
		DelayNormal = 1 << 16,
		NoSharedDelay = 1 << 17,
	}

	/**
	 * @enum ImGuiDockNodeFlags
	 * @desc Flags for ImGui::DockSpace(), shared/inherited by child nodes.
	 *
	 */
	enum ImGuiDockNodeFlags {
		None = 0,
		KeepAliveOnly = 1 << 0,
		NoDockingOverCentralNode = 1 << 2,
		PassthruCentralNode = 1 << 3,
		NoDockingSplit = 1 << 4,
		NoResize = 1 << 5,
		AutoHideTabBar = 1 << 6,
		NoUndocking = 1 << 7,
		NoSplit = ImGuiDockNodeFlags.NoDockingSplit,
		NoDockingInCentralNode = ImGuiDockNodeFlags.NoDockingOverCentralNode,
	}

	/**
	 * @enum ImGuiDragDropFlags
	 * @desc Flags for ImGui::BeginDragDropSource(), ImGui::AcceptDragDropPayload()
	 *
	 */
	enum ImGuiDragDropFlags {
		None = 0,
		SourceNoPreviewTooltip = 1 << 0,
		SourceNoDisableHover = 1 << 1,
		SourceNoHoldToOpenOthers = 1 << 2,
		SourceAllowNullID = 1 << 3,
		SourceExtern = 1 << 4,
		PayloadAutoExpire = 1 << 5,
		PayloadNoCrossContext = 1 << 6,
		PayloadNoCrossProcess = 1 << 7,
		AcceptBeforeDelivery = 1 << 10,
		AcceptNoDrawDefaultRect = 1 << 11,
		AcceptNoPreviewTooltip = 1 << 12,
		AcceptPeekOnly = ImGuiDragDropFlags.AcceptBeforeDelivery | ImGuiDragDropFlags.AcceptNoDrawDefaultRect,
		SourceAutoExpirePayload = ImGuiDragDropFlags.PayloadAutoExpire,
	}

	/**
	 * @enum ImGuiDataType
	 * @desc float[4]: Standard type for colors. User code may use this type.
	 *
	 */
	enum ImGuiDataType {
		S8,
		U8,
		S16,
		U16,
		S32,
		U32,
		S64,
		U64,
		Float,
		Double,
		Bool,
		String,
	}

	/**
	 * @enum ImGuiDir
	 * @desc A cardinal direction
	 *
	 */
	enum ImGuiDir {
		None = - 1,
		Left = 0,
		Right = 1,
		Up = 2,
		Down = 3,
	}

	/**
	 * @enum ImGuiSortDirection
	 * @desc A sorting direction
	 *
	 */
	enum ImGuiSortDirection {
		None = 0,
		Ascending = 1,
		Descending = 2,
	}

	/**
	 * @enum ImGuiInputFlags
	 * @desc Flags for Shortcut(), SetNextItemShortcut(),
	 *
	 */
	enum ImGuiInputFlags {
		None = 0,
		Repeat = 1 << 0,
		RouteActive = 1 << 10,
		RouteFocused = 1 << 11,
		RouteGlobal = 1 << 12,
		RouteAlways = 1 << 13,
		RouteOverFocused = 1 << 14,
		RouteOverActive = 1 << 15,
		RouteUnlessBgFocused = 1 << 16,
		RouteFromRootWindow = 1 << 17,
		Tooltip = 1 << 18,
	}

	/**
	 * @enum ImGuiConfigFlags
	 * @desc Configuration flags stored in io.ConfigFlags. Set by user/application.
	 *
	 */
	enum ImGuiConfigFlags {
		None = 0,
		NavEnableKeyboard = 1 << 0,
		NavEnableGamepad = 1 << 1,
		NoMouse = 1 << 4,
		NoMouseCursorChange = 1 << 5,
		NoKeyboard = 1 << 6,
		DockingEnable = 1 << 7,
		ViewportsEnable = 1 << 10,
		IsSRGB = 1 << 20,
		IsTouchScreen = 1 << 21,
		NavEnableSetMousePos = 1 << 2,
		NavNoCaptureKeyboard = 1 << 3,
		DpiEnableScaleFonts = 1 << 14,
		DpiEnableScaleViewports = 1 << 15,
	}

	/**
	 * @enum ImGuiBackendFlags
	 * @desc Backend capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom backend.
	 *
	 */
	enum ImGuiBackendFlags {
		None = 0,
		HasGamepad = 1 << 0,
		HasMouseCursors = 1 << 1,
		HasSetMousePos = 1 << 2,
		RendererHasVtxOffset = 1 << 3,
		RendererHasTextures = 1 << 4,
		PlatformHasViewports = 1 << 10,
		HasMouseHoveredViewport = 1 << 11,
		RendererHasViewports = 1 << 12,
	}

	/**
	 * @enum ImGuiCol
	 * @desc Enumeration for PushStyleColor() / PopStyleColor()
	 *
	 */
	enum ImGuiCol {
		Text,
		TextDisabled,
		WindowBg,
		ChildBg,
		PopupBg,
		Border,
		BorderShadow,
		FrameBg,
		FrameBgHovered,
		FrameBgActive,
		TitleBg,
		TitleBgActive,
		TitleBgCollapsed,
		MenuBarBg,
		ScrollbarBg,
		ScrollbarGrab,
		ScrollbarGrabHovered,
		ScrollbarGrabActive,
		CheckMark,
		SliderGrab,
		SliderGrabActive,
		Button,
		ButtonHovered,
		ButtonActive,
		Header,
		HeaderHovered,
		HeaderActive,
		Separator,
		SeparatorHovered,
		SeparatorActive,
		ResizeGrip,
		ResizeGripHovered,
		ResizeGripActive,
		InputTextCursor,
		TabHovered,
		Tab,
		TabSelected,
		TabSelectedOverline,
		TabDimmed,
		TabDimmedSelected,
		TabDimmedSelectedOverline,
		DockingPreview,
		DockingEmptyBg,
		PlotLines,
		PlotLinesHovered,
		PlotHistogram,
		PlotHistogramHovered,
		TableHeaderBg,
		TableBorderStrong,
		TableBorderLight,
		TableRowBg,
		TableRowBgAlt,
		TextLink,
		TextSelectedBg,
		TreeLines,
		DragDropTarget,
		NavCursor,
		NavWindowingHighlight,
		NavWindowingDimBg,
		ModalWindowDimBg,
		COUNT,
		TabActive = ImGuiCol.TabSelected,
		TabUnfocused = ImGuiCol.TabDimmed,
		TabUnfocusedActive = ImGuiCol.TabDimmedSelected,
		NavHighlight = ImGuiCol.NavCursor,
	}

	/**
	 * @enum ImGuiStyleVar
	 * @desc Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
	 *
	 */
	enum ImGuiStyleVar {
		Alpha,
		DisabledAlpha,
		WindowPadding,
		WindowRounding,
		WindowBorderSize,
		WindowMinSize,
		WindowTitleAlign,
		ChildRounding,
		ChildBorderSize,
		PopupRounding,
		PopupBorderSize,
		FramePadding,
		FrameRounding,
		FrameBorderSize,
		ItemSpacing,
		ItemInnerSpacing,
		IndentSpacing,
		CellPadding,
		ScrollbarSize,
		ScrollbarRounding,
		GrabMinSize,
		GrabRounding,
		ImageBorderSize,
		TabRounding,
		TabBorderSize,
		TabMinWidthBase,
		TabMinWidthShrink,
		TabBarBorderSize,
		TabBarOverlineSize,
		TableAngledHeadersAngle,
		TableAngledHeadersTextAlign,
		TreeLinesSize,
		TreeLinesRounding,
		ButtonTextAlign,
		SelectableTextAlign,
		SeparatorTextBorderSize,
		SeparatorTextAlign,
		SeparatorTextPadding,
		DockingSeparatorSize,
	}

	/**
	 * @enum ImGuiButtonFlags
	 * @desc Flags for InvisibleButton() [extended in imgui_internal.h]
	 *
	 */
	enum ImGuiButtonFlags {
		None = 0,
		MouseButtonLeft = 1 << 0,
		MouseButtonRight = 1 << 1,
		MouseButtonMiddle = 1 << 2,
		MouseButtonMask_ = ImGuiButtonFlags.MouseButtonLeft | ImGuiButtonFlags.MouseButtonRight | ImGuiButtonFlags.MouseButtonMiddle,
		EnableNav = 1 << 3,
	}

	/**
	 * @enum ImGuiColorEditFlags
	 * @desc Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
	 *
	 */
	enum ImGuiColorEditFlags {
		None = 0,
		NoAlpha = 1 << 1,
		NoPicker = 1 << 2,
		NoOptions = 1 << 3,
		NoSmallPreview = 1 << 4,
		NoInputs = 1 << 5,
		NoTooltip = 1 << 6,
		NoLabel = 1 << 7,
		NoSidePreview = 1 << 8,
		NoDragDrop = 1 << 9,
		NoBorder = 1 << 10,
		AlphaOpaque = 1 << 11,
		AlphaNoBg = 1 << 12,
		AlphaPreviewHalf = 1 << 13,
		AlphaBar = 1 << 16,
		HDR = 1 << 19,
		DisplayRGB = 1 << 20,
		DisplayHSV = 1 << 21,
		DisplayHex = 1 << 22,
		Uint8 = 1 << 23,
		Float = 1 << 24,
		PickerHueBar = 1 << 25,
		PickerHueWheel = 1 << 26,
		InputRGB = 1 << 27,
		InputHSV = 1 << 28,
		DefaultOptions_ = ImGuiColorEditFlags.Uint8 | ImGuiColorEditFlags.DisplayRGB | ImGuiColorEditFlags.InputRGB | ImGuiColorEditFlags.PickerHueBar,
		AlphaMask_ = ImGuiColorEditFlags.NoAlpha | ImGuiColorEditFlags.AlphaOpaque | ImGuiColorEditFlags.AlphaNoBg | ImGuiColorEditFlags.AlphaPreviewHalf,
		DisplayMask_ = ImGuiColorEditFlags.DisplayRGB | ImGuiColorEditFlags.DisplayHSV | ImGuiColorEditFlags.DisplayHex,
		DataTypeMask_ = ImGuiColorEditFlags.Uint8 | ImGuiColorEditFlags.Float,
		PickerMask_ = ImGuiColorEditFlags.PickerHueWheel | ImGuiColorEditFlags.PickerHueBar,
		InputMask_ = ImGuiColorEditFlags.InputRGB | ImGuiColorEditFlags.InputHSV,
		AlphaPreview = 0,
	}

	/**
	 * @enum ImGuiSliderFlags
	 * @desc Flags for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
	 *
	 */
	enum ImGuiSliderFlags {
		None = 0,
		Logarithmic = 1 << 5,
		NoRoundToFormat = 1 << 6,
		NoInput = 1 << 7,
		WrapAround = 1 << 8,
		ClampOnInput = 1 << 9,
		ClampZeroRange = 1 << 10,
		NoSpeedTweaks = 1 << 11,
		AlwaysClamp = ImGuiSliderFlags.ClampOnInput | ImGuiSliderFlags.ClampZeroRange,
		InvalidMask_ = 0x7000000F,
	}

	/**
	 * @enum ImGuiMouseButton
	 * @desc Identify a mouse button.
	 *
	 */
	enum ImGuiMouseButton {
		Left = 0,
		Right = 1,
		Middle = 2,
		COUNT = 5,
	}

	/**
	 * @enum ImGuiMouseCursor
	 * @desc Enumeration for GetMouseCursor()
	 *
	 */
	enum ImGuiMouseCursor {
		None = - 1,
		Arrow = 0,
		TextInput,
		ResizeAll,
		ResizeNS,
		ResizeEW,
		ResizeNESW,
		ResizeNWSE,
		Hand,
		Wait,
		Progress,
		NotAllowed,
	}

	/**
	 * @enum ImGuiMouseSource
	 * @desc Enumeration for AddMouseSourceEvent() actual source of Mouse Input data.
	 *
	 */
	enum ImGuiMouseSource {
		Mouse = 0,
		TouchScreen,
		Pen,
	}

	/**
	 * @enum ImGuiCond
	 * @desc Enumeration for ImGui::SetNextWindow***(), SetWindow***(), SetNextItem***() functions
	 *
	 */
	enum ImGuiCond {
		None = 0,
		Always = 1 << 0,
		Once = 1 << 1,
		FirstUseEver = 1 << 2,
		Appearing = 1 << 3,
	}

	/**
	 * @enum ImGuiTableFlags
	 * @desc Flags for ImGui::BeginTable()
	 *
	 */
	enum ImGuiTableFlags {
		None = 0,
		Resizable = 1 << 0,
		Reorderable = 1 << 1,
		Hideable = 1 << 2,
		Sortable = 1 << 3,
		NoSavedSettings = 1 << 4,
		ContextMenuInBody = 1 << 5,
		RowBg = 1 << 6,
		BordersInnerH = 1 << 7,
		BordersOuterH = 1 << 8,
		BordersInnerV = 1 << 9,
		BordersOuterV = 1 << 10,
		BordersH = ImGuiTableFlags.BordersInnerH | ImGuiTableFlags.BordersOuterH,
		BordersV = ImGuiTableFlags.BordersInnerV | ImGuiTableFlags.BordersOuterV,
		BordersInner = ImGuiTableFlags.BordersInnerV | ImGuiTableFlags.BordersInnerH,
		BordersOuter = ImGuiTableFlags.BordersOuterV | ImGuiTableFlags.BordersOuterH,
		Borders = ImGuiTableFlags.BordersInner | ImGuiTableFlags.BordersOuter,
		NoBordersInBody = 1 << 11,
		NoBordersInBodyUntilResize = 1 << 12,
		SizingFixedFit = 1 << 13,
		SizingFixedSame = 2 << 13,
		SizingStretchProp = 3 << 13,
		SizingStretchSame = 4 << 13,
		NoHostExtendX = 1 << 16,
		NoHostExtendY = 1 << 17,
		NoKeepColumnsVisible = 1 << 18,
		PreciseWidths = 1 << 19,
		NoClip = 1 << 20,
		PadOuterX = 1 << 21,
		NoPadOuterX = 1 << 22,
		NoPadInnerX = 1 << 23,
		ScrollX = 1 << 24,
		ScrollY = 1 << 25,
		SortMulti = 1 << 26,
		SortTristate = 1 << 27,
		HighlightHoveredColumn = 1 << 28,
		SizingMask_ = ImGuiTableFlags.SizingFixedFit | ImGuiTableFlags.SizingFixedSame | ImGuiTableFlags.SizingStretchProp | ImGuiTableFlags.SizingStretchSame,
	}

	/**
	 * @enum ImGuiTableColumnFlags
	 * @desc Flags for ImGui::TableSetupColumn()
	 *
	 */
	enum ImGuiTableColumnFlags {
		None = 0,
		Disabled = 1 << 0,
		DefaultHide = 1 << 1,
		DefaultSort = 1 << 2,
		WidthStretch = 1 << 3,
		WidthFixed = 1 << 4,
		NoResize = 1 << 5,
		NoReorder = 1 << 6,
		NoHide = 1 << 7,
		NoClip = 1 << 8,
		NoSort = 1 << 9,
		NoSortAscending = 1 << 10,
		NoSortDescending = 1 << 11,
		NoHeaderLabel = 1 << 12,
		NoHeaderWidth = 1 << 13,
		PreferSortAscending = 1 << 14,
		PreferSortDescending = 1 << 15,
		IndentEnable = 1 << 16,
		IndentDisable = 1 << 17,
		AngledHeader = 1 << 18,
		IsEnabled = 1 << 24,
		IsVisible = 1 << 25,
		IsSorted = 1 << 26,
		IsHovered = 1 << 27,
		WidthMask_ = ImGuiTableColumnFlags.WidthStretch | ImGuiTableColumnFlags.WidthFixed,
		IndentMask_ = ImGuiTableColumnFlags.IndentEnable | ImGuiTableColumnFlags.IndentDisable,
		StatusMask_ = ImGuiTableColumnFlags.IsEnabled | ImGuiTableColumnFlags.IsVisible | ImGuiTableColumnFlags.IsSorted | ImGuiTableColumnFlags.IsHovered,
		NoDirectResize_ = 1 << 30,
	}

	/**
	 * @enum ImGuiTableRowFlags
	 * @desc Flags for ImGui::TableNextRow()
	 *
	 */
	enum ImGuiTableRowFlags {
		None = 0,
		Headers = 1 << 0,
	}

	/**
	 * @enum ImGuiTableBgTarget
	 * @desc Enum for ImGui::TableSetBgColor()
	 *
	 */
	enum ImGuiTableBgTarget {
		None = 0,
		RowBg0 = 1,
		RowBg1 = 2,
		CellBg = 3,
	}

	/**
	 * @enum ImGuiMultiSelectFlags
	 * @desc Multi-selection system
	 *
	 */
	enum ImGuiMultiSelectFlags {
		None = 0,
		SingleSelect = 1 << 0,
		NoSelectAll = 1 << 1,
		NoRangeSelect = 1 << 2,
		NoAutoSelect = 1 << 3,
		NoAutoClear = 1 << 4,
		NoAutoClearOnReselect = 1 << 5,
		BoxSelect1d = 1 << 6,
		BoxSelect2d = 1 << 7,
		BoxSelectNoScroll = 1 << 8,
		ClearOnEscape = 1 << 9,
		ClearOnClickVoid = 1 << 10,
		ScopeWindow = 1 << 11,
		ScopeRect = 1 << 12,
		SelectOnClick = 1 << 13,
		SelectOnClickRelease = 1 << 14,
		NavWrapX = 1 << 16,
	}

	/**
	 * @enum ImGuiSelectionRequestType
	 * @desc Selection request type
	 *
	 */
	enum ImGuiSelectionRequestType {
		None = 0,
		SetAll,
		SetRange,
	}

	/**
	 * @enum ImDrawFlags
	 * @desc Flags for ImDrawList functions
	 *
	 */
	enum ImDrawFlags {
		None = 0,
		Closed = 1 << 0,
		RoundCornersTopLeft = 1 << 4,
		RoundCornersTopRight = 1 << 5,
		RoundCornersBottomLeft = 1 << 6,
		RoundCornersBottomRight = 1 << 7,
		RoundCornersNone = 1 << 8,
		RoundCornersTop = ImDrawFlags.RoundCornersTopLeft | ImDrawFlags.RoundCornersTopRight,
		RoundCornersBottom = ImDrawFlags.RoundCornersBottomLeft | ImDrawFlags.RoundCornersBottomRight,
		RoundCornersLeft = ImDrawFlags.RoundCornersBottomLeft | ImDrawFlags.RoundCornersTopLeft,
		RoundCornersRight = ImDrawFlags.RoundCornersBottomRight | ImDrawFlags.RoundCornersTopRight,
		RoundCornersAll = ImDrawFlags.RoundCornersTopLeft | ImDrawFlags.RoundCornersTopRight | ImDrawFlags.RoundCornersBottomLeft | ImDrawFlags.RoundCornersBottomRight,
		RoundCornersDefault_ = ImDrawFlags.RoundCornersAll,
		RoundCornersMask_ = ImDrawFlags.RoundCornersAll | ImDrawFlags.RoundCornersNone,
	}

	/**
	 * @enum ImDrawListFlags
	 * @desc Flags for ImDrawList instance. Those are set automatically by ImGui:: functions from ImGuiIO settings, and generally not manipulated directly.
	 *
	 */
	enum ImDrawListFlags {
		None = 0,
		AntiAliasedLines = 1 << 0,
		AntiAliasedLinesUseTex = 1 << 1,
		AntiAliasedFill = 1 << 2,
		AllowVtxOffset = 1 << 3,
	}

	/**
	 * @enum ImTextureFormat
	 * @desc X11 headers are leaking this.
	 *
	 */
	enum ImTextureFormat {
		RGBA32,
		Alpha8,
	}

	/**
	 * @enum ImTextureStatus
	 * @desc Status of a texture to communicate with Renderer Backend.
	 *
	 */
	enum ImTextureStatus {
		OK,
		Destroyed,
		WantCreate,
		WantUpdates,
		WantDestroy,
	}

	/**
	 * @enum ImFontAtlasFlags
	 * @desc Flags for ImFontAtlas build
	 *
	 */
	enum ImFontAtlasFlags {
		None = 0,
		NoPowerOfTwoHeight = 1 << 0,
		NoMouseCursors = 1 << 1,
		NoBakedLines = 1 << 2,
	}

	/**
	 * @enum ImFontFlags
	 * @desc Font flags
	 *
	 */
	enum ImFontFlags {
		None = 0,
		NoLoadError = 1 << 1,
		NoLoadGlyphs = 1 << 2,
		LockBakedSizes = 1 << 3,
	}

	/**
	 * @enum ImGuiViewportFlags
	 * @desc Flags stored in ImGuiViewport::Flags, giving indications to the platform backends.
	 *
	 */
	enum ImGuiViewportFlags {
		None = 0,
		IsPlatformWindow = 1 << 0,
		IsPlatformMonitor = 1 << 1,
		OwnedByApp = 1 << 2,
		NoDecoration = 1 << 3,
		NoTaskBarIcon = 1 << 4,
		NoFocusOnAppearing = 1 << 5,
		NoFocusOnClick = 1 << 6,
		NoInputs = 1 << 7,
		NoRendererClear = 1 << 8,
		NoAutoMerge = 1 << 9,
		TopMost = 1 << 10,
		CanHostOtherWindows = 1 << 11,
		IsMinimized = 1 << 12,
		IsFocused = 1 << 13,
	}

	#endregion


    #region Internal
    /// @desc Where the (GML) magic happens, safe from code generation
    static __imgm = __ImGM();

    static __state = undefined;
    static __window = undefined;

    static __CreateVtxFormat = function() {
        vertex_format_begin();
        vertex_format_add_position();
        vertex_format_add_texcoord();
        vertex_format_add_color();
        return vertex_format_end();
    }

    static __mainWindowHandle = window_handle();
    static __mainWindow = undefined;
    static __vtxFormat = __CreateVtxFormat();
    static __vtxFormatStride = vertex_format_get_info(__vtxFormat).stride;
    static __vtxBuffer = (function()
    {
        var vtxBuffer = vertex_create_buffer();
        vertex_begin(vtxBuffer, __vtxFormat);
        vertex_end(vtxBuffer);
        return vtxBuffer;
    })();

    static __inputMapping = __imgui_create_input_mapping();
    static __cursorMapping = __imgui_create_cursor_mapping();
    static __GFlags = IMGM_GFLAGS;

    static __cursorPrev = -1;
    static __inputRequested = false;
    static __inputStore = undefined;

    static __initialized = false;

    static toString = function() {
        return $"<ImGui {string(__window)}>";
    }

    static __Initialize = function(ww_or_state_or_cfg=undefined, ctx=undefined) {
        if ImGui.__initialized return;

        // Setup received parameters
        var ww = undefined,
        _ctx_created = false,
        _cbf_created = true,
        _fbf_created = true,
        _config_override_set = ImGuiConfigFlags.None,
        new_state = undefined;

        if is_instanceof(ww_or_state_or_cfg, ImGuiState) {
            new_state = ww_or_state_or_cfg;

        } else if is_int32(ww_or_state_or_cfg) or is_int64(ww_or_state_or_cfg) or is_real(ww_or_state_or_cfg){
            _config_override_set = ww_or_state_or_cfg;
        } else if is_struct(ww_or_state_or_cfg) {
            ww = ww_or_state_or_cfg;

        }

        if ww == undefined {
            ImGui.__mainWindow ??= new ImGuiBaseMainWindow();
            ww = ImGui.__mainWindow;
        }

        ww ??= ImGui.__mainWindow;
        new_state ??= new ImGuiState();

        if is_int32(ctx) or is_int64(ctx) or is_real(ctx) {
            _config_override_set = ctx;
            ctx = undefined;
        }
        if ctx == undefined {
            if new_state.Engine.Context != pointer_null {
                ctx = new_state.Engine.Context;
            } else {
                ctx = CreateContext();
                _ctx_created = true;
            }
        }

        // Setup the state.
        new_state.Engine.Window = ww;
        new_state.Engine.Context = ctx;

        ImGui.__window = ww;

        var inited = new_state.__Initialize(_config_override_set);

        if inited == pointer_null or inited == undefined {
            if _ctx_created DestroyContext(__state.Engine.Context);
            if _cbf_created buffer_delete(__state.Renderer.CmdBuffer);
            if _fbf_created buffer_delete(__state.Renderer.FontBuffer);
            __state.Engine.Context = pointer_null;
            __state.Renderer.CmdBuffer = -1;
            __state.Renderer.FontBuffer = -1;
            ImGui.__initialized = false;
            return false;
        }
        ImGui.__initialized = true;
        new_state.Use();
		ImGuiExtMethodCall("__ImGui_Initialize", undefined, __state, true);
        return true;
    }

    static __Shutdown = function(state=undefined) {
        if !ImGui.__initialized return;
        state ??= __state; if state != __state state.Use();

        ImGuiExtMethodCall("__ImGui_Shutdown", undefined, __state, true);

        if (__imgui_shutdown(__state.Engine.Context)) {
            ImGui.__initialized = false;
            __state.Destroy();
            delete __state;
            return true;
        }
        return false;
    }

    static __NewFrame = function(state=undefined) {
        if !ImGui.__initialized return;
        state ??= __state; if state != __state state.Use();

        ImGui.__imgm.Utils.Update();

        var _dwidth = display_get_width(), _dheight = display_get_height(), _focus = false;
        var _wwidth = 0, _wheight = 0;

        _wwidth = __state.Engine.Window.GetWidth();
        _wheight = __state.Engine.Window.GetHeight();
        _focus = __state.Engine.Window.HasFocus();

        // Check surface
        if (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM) {
            if (!surface_exists(__state.Renderer.Surface)) {
                __state.Renderer.Surface = surface_create(max(1, _wwidth), max(1, _wheight));
            }
        }

        if _wwidth != 0 __state.Display.Width = _wwidth;
        if _wheight != 0 __state.Display.Height = _wheight;
        __state.Engine.Time = delta_time / 1_000_000;
        __state.Engine.Framerate = game_get_speed(gamespeed_fps);

        if ((_wwidth > 0 && _wheight > 0)) {
            for(var i = ImGuiKey.NamedKey_BEGIN; i < ImGuiKey.NamedKey_END; i++) {
                var key = ImGui.__inputMapping[i];
                if (key > -1) __imgui_key(i, keyboard_check_direct(key));
            }
            __imgui_key(ImGuiKey.ImGuiMod_Ctrl, keyboard_check_direct(vk_lcontrol));
            __imgui_key(ImGuiKey.ImGuiMod_Shift, keyboard_check_direct(vk_lshift));
            __imgui_key(ImGuiKey.ImGuiMod_Alt, keyboard_check_direct(vk_lalt));

            if (__imgui_want_text_input(undefined)) {
                if (!__inputRequested) {
                    __inputRequested = true;
                    __inputStore = keyboard_string;
                    keyboard_string = "";
                }
                if (__imgui_input(keyboard_string)) keyboard_string = "";
            } else {
                if (__inputRequested) {
                    keyboard_string = __inputStore;
                    __inputRequested = false;
                }
            }

            var _x = __state.Engine.Window.GetX();
            var _y = __state.Engine.Window.GetY();

            var _do_mouse = (_focus == true);

            if _do_mouse {
                __state.Input.Mouse.X = __state.Engine.Window.MouseGetX();
                __state.Input.Mouse.Y = __state.Engine.Window.MouseGetY();
                for(var i = 0; i < 3; i++) __imgui_mouse(i, __state.Engine.Window.MouseCheckButton(i + 1));
                if (__state.Engine.Window.MouseWheelUp()) __imgui_mouse_wheel(0, 1);
                else if (__state.Engine.Window.MouseWheelDown()) __imgui_mouse_wheel(0, -1);

                var _cursor = __imgui_mouse_cursor();
                if (_cursor != __cursorPrev) {
                    __state.Engine.Window.SetCursor(ImGui.__cursorMapping[_cursor + 1]);
                    __cursorPrev = _cursor;
                }
            }
        }

        var _data = __state.__GetData();
        __imgui_new_frame(_data);
        ImGuiExtMethodCall("__ImGui_NewFrame", undefined, __state, true);

        if (buffer_peek(__state.Renderer.FontBuffer, 0, buffer_bool)) {
            if (sprite_exists(__state.Display.Font)) sprite_delete(__state.Display.Font);
            var font = surface_create(buffer_peek(__state.Renderer.FontBuffer, 1, buffer_u32), buffer_peek(__state.Renderer.FontBuffer, 5, buffer_u32));
            buffer_set_surface(__state.Renderer.FontBuffer, font, 9);
            __state.Display.Font = sprite_create_from_surface(font, 0, 0, surface_get_width(font), surface_get_height(font), false, false, 0, 0);
            surface_free(font);
            __state.Renderer.UpdateFont = false;
        }
    }

    static __EndFrame = function(state=undefined) {
        if !ImGui.__initialized return;
        state ??= __state; if state != __state state.Use();

        __imgui_end_frame();
        ImGuiExtMethodCall("__ImGui_EndFrame", undefined, __state, true);
    }

    static __Render = function(state=undefined) {
        if !ImGui.__initialized return;
        state ??= __state; if state != __state state.Use();

        __imgui_render();
        ImGuiExtMethodCall("__ImGui_Render", undefined, __state, true);
    }

    static __Draw = function(state=undefined, _rescale=true) {
        if !ImGui.__initialized return;
        state ??= __state; if state != __state state.Use();

        if (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM) {
            if (!surface_exists(__state.Renderer.Surface)) {
                __state.Renderer.Surface = surface_create(max(1, __state.Display.Width), max(1, __state.Display.Height));
            }
        }

        var _w = display_get_gui_width(), _h = display_get_gui_height();
        var _ww = __state.Engine.Window.GetWidth();
        var _wh = __state.Engine.Window.GetHeight();

		if (_rescale) {
	        if (_ww > 0 and _wh > 0) {
				if (_w != _ww && _h != _wh) {
					if (__state.Engine.Window.GetHandle() == __mainWindowHandle) {
						display_set_gui_size(_ww, _wh);
						surface_resize(application_surface, _ww, _wh);
					}
				}
			}
		}

        var _data = __state.__GetData();
        __imgui_draw(_data);
        ImGuiExtMethodCall("__ImGui_Draw", undefined, __state, true);

        if (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM) {

            var cmdBuffer = __state.Renderer.CmdBuffer;
            buffer_seek(cmdBuffer, buffer_seek_start, 0);
            if (buffer_read(cmdBuffer, buffer_bool)) { // data->Valid

                //Cache static values for better performance inside the loop
                var vtxBuffer = __vtxBuffer;
                var vtxStride = __vtxFormatStride;

                //Keep a copy of the current scissor state for later reset
                var oldScissor = gpu_get_scissor();

                surface_set_target(__state.Renderer.Surface);
                gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha); //Pre-multiplied alpha blend mode
                draw_clear_alpha(0, 0);
                var list_count = buffer_read(cmdBuffer, buffer_u32);
                for(var i = 0; i < list_count; i++) {
                    var cmd_count = buffer_read(cmdBuffer, buffer_u32);
                    for(var j = 0; j < cmd_count; j++) {
                        if (!buffer_read(cmdBuffer, buffer_bool)) { // UserCallback != nullptr
                            var tex_data = buffer_read(cmdBuffer, buffer_u32);
                            var tex_id = -1;
                            switch (tex_data & 0xF) {
                                case ImGuiTextureType.Surface: {
                                    tex_id = surface_get_texture(tex_data >> 16);
                                    break;
                                }

                                case ImGuiTextureType.Font: {
                                    tex_id = sprite_get_texture(__state.Display.Font, 0);
                                    break;
                                }

                                case ImGuiTextureType.Sprite: {
                                    tex_id = sprite_get_texture(tex_data >> 16, (tex_data >> 4) & 0xFFF);
                                    break;
                                }
                            }

                            var clip_x1 = buffer_read(cmdBuffer, buffer_f32);
                            var clip_y1 = buffer_read(cmdBuffer, buffer_f32);
                            var clip_x2 = buffer_read(cmdBuffer, buffer_f32);
                            var clip_y2 = buffer_read(cmdBuffer, buffer_f32);
                            gpu_set_scissor(clip_x1, clip_y1, clip_x2 - clip_x1, clip_y2 - clip_y1);

                            var vtx_count = buffer_read(cmdBuffer, buffer_u32);
                            vertex_update_buffer_from_buffer(vtxBuffer, 0, cmdBuffer, buffer_tell(cmdBuffer), vtxStride*vtx_count);
                            vertex_submit_ext(vtxBuffer, pr_trianglelist, tex_id, 0, vtx_count)

                            buffer_seek(cmdBuffer, buffer_seek_relative, vtxStride*vtx_count);
                        }
                    }
                }
                surface_reset_target();
                gpu_set_blendmode(bm_normal);
                gpu_set_scissor(oldScissor);

                if _ww > 0 and _wh > 0 {
                    if (__state.Engine.Window[$ "DrawBegin"]) {
                        __state.Engine.Window.DrawBegin();
                    }
                    if (__state.Engine.Window[$ "DrawClear"]) {
                        __state.Engine.Window.DrawClear();
                    }

                    draw_surface(__state.Renderer.Surface, 0, 0);

                    if (__state.Engine.Window[$ "DrawEnd"]) {
                        __state.Engine.Window.DrawEnd();
                    }
                }
            }
        }
    }

    return self;
};


new ImGui();
