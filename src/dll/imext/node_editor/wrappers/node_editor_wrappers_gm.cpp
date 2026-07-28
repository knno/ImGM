#pragma once
#include "../imgm.h"
#include "../internal/imgui_node_editor.h"

static inline ax::NodeEditor::NodeId __node_editor_node_id_from_rvalue(RValue* value)
{
	return ax::NodeEditor::NodeId(reinterpret_cast<void*>(static_cast<uintptr_t>(value != nullptr ? value->asInt64() : 0)));
}

static inline ax::NodeEditor::LinkId __node_editor_link_id_from_rvalue(RValue* value)
{
	return ax::NodeEditor::LinkId(reinterpret_cast<void*>(static_cast<uintptr_t>(value != nullptr ? value->asInt64() : 0)));
}

static inline ax::NodeEditor::PinId __node_editor_pin_id_from_rvalue(RValue* value)
{
	return ax::NodeEditor::PinId(reinterpret_cast<void*>(static_cast<uintptr_t>(value != nullptr ? value->asInt64() : 0)));
}

/**
 * @desc Creates a new NodeEditor context.
 */
GMFUNC(__imext_node_editor_create_editor) {
	GMOVERRIDE(CreateEditor)

	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::CreateEditor(nullptr);
}

/**
 * @desc Destroys a NodeEditor context.
 * @param editor Pointer to the editor context created by CreateEditor.
 */
GMFUNC(__imext_node_editor_destroy_editor) {
	GMOVERRIDE(DestroyEditor)
	RValue* editor = &arg[0];
	GMDEFAULT(undefined)

	if (editor->kind != VALUE_UNDEFINED && editor->kind != VALUE_PTR) {
		Result.kind = VALUE_UNDEFINED;
		return;
	}

	ax::NodeEditor::DestroyEditor(reinterpret_cast<ax::NodeEditor::EditorContext*>(editor->ptr));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the current editor context.
 * @param editor Pointer to the editor context.
 */
GMFUNC(__imext_node_editor_set_current_editor) {
	GMOVERRIDE(SetCurrentEditor)
	RValue* editor = &arg[0];
	GMDEFAULT(undefined)

	ax::NodeEditor::SetCurrentEditor(editor->kind == VALUE_UNDEFINED ? nullptr : reinterpret_cast<ax::NodeEditor::EditorContext*>(editor->ptr));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the current editor context pointer.
 */
GMFUNC(__imext_node_editor_get_current_editor) {
	GMOVERRIDE(GetCurrentEditor)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetCurrentEditor();
}

/**
 * @desc Returns the current editor configuration.
 */
GMFUNC(__imext_node_editor_get_config) {
	GMOVERRIDE(GetConfig)
	Result.kind = VALUE_UNDEFINED;
	(void)ax::NodeEditor::GetConfig(nullptr);
}

/**
 * @desc Returns the editor style object.
 */
GMFUNC(__imext_node_editor_get_style) {
	GMOVERRIDE(GetStyle)
	Result.kind = VALUE_UNDEFINED;
	(void)ax::NodeEditor::GetStyle();
}

/**
 * @desc Returns the human-readable name for a style color.
 * @param color_index The style color index.
 */
GMFUNC(__imext_node_editor_get_style_color_name) {
	GMOVERRIDE(GetStyleColorName)
	int color_index = static_cast<int>(YYGetReal(arg, 0));
	Result.kind = VALUE_STRING;
	YYCreateString(
		&Result,
		ax::NodeEditor::GetStyleColorName(static_cast<ax::NodeEditor::StyleColor>(color_index))
	);
}

/**
 * @desc Pushes a color override onto the current editor style stack.
 * @param color_index The style color index.
 * @param color A GameMaker color value.
 * @param alpha The alpha component.
 */
GMFUNC(__imext_node_editor_push_style_color) {
	GMOVERRIDE(PushStyleColor)
	int color_index = static_cast<int>(YYGetReal(arg, 0));
	double col = YYGetReal(arg, 1);
	float alpha = static_cast<float>(YYGetReal(arg, 2));
	ax::NodeEditor::PushStyleColor(
		static_cast<ax::NodeEditor::StyleColor>(color_index),
		GMCOLOR_TO(col, alpha)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Pops one or more style color entries from the current editor style stack.
 * @param count The number of entries to pop.
 */
GMFUNC(__imext_node_editor_pop_style_color) {
	GMOVERRIDE(PopStyleColor)
	int count = static_cast<int>(YYGetReal(arg, 0));
	ax::NodeEditor::PopStyleColor(count);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Pushes a style variable value onto the current editor style stack.
 * @param var_index The style variable index.
 * @param value The value to push.
 */
GMFUNC(__imext_node_editor_push_style_var) {
	GMOVERRIDE(PushStyleVar)
	int var_index = static_cast<int>(YYGetReal(arg, 0));
	float value = static_cast<float>(YYGetReal(arg, 1));
	ax::NodeEditor::PushStyleVar(
		static_cast<ax::NodeEditor::StyleVar>(var_index),
		value
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Pushes a 2D style variable value onto the current editor style stack.
 * @param var_index The style variable index.
 * @param x The X component.
 * @param y The Y component.
 */
GMFUNC(__imext_node_editor_push_style_var_vec2) {
	GMOVERRIDE(PushStyleVar)
	int var_index = static_cast<int>(YYGetReal(arg, 0));
	float x = static_cast<float>(YYGetReal(arg, 1));
	float y = static_cast<float>(YYGetReal(arg, 2));
	ax::NodeEditor::PushStyleVar(
		static_cast<ax::NodeEditor::StyleVar>(var_index),
		ImVec2(x, y)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Pushes a 4D style variable value onto the current editor style stack.
 * @param var_index The style variable index.
 * @param x The X component.
 * @param y The Y component.
 * @param z The Z component.
 * @param w The W component.
 */
GMFUNC(__imext_node_editor_push_style_var_vec4) {
	GMOVERRIDE(PushStyleVar)
	int var_index = static_cast<int>(YYGetReal(arg, 0));
	float x = static_cast<float>(YYGetReal(arg, 1));
	float y = static_cast<float>(YYGetReal(arg, 2));
	float z = static_cast<float>(YYGetReal(arg, 3));
	float w = static_cast<float>(YYGetReal(arg, 4));
	ax::NodeEditor::PushStyleVar(
		static_cast<ax::NodeEditor::StyleVar>(var_index),
		ImVec4(x, y, z, w)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Pops one or more style variables from the current editor style stack.
 * @param count The number of entries to pop.
 */
GMFUNC(__imext_node_editor_pop_style_var) {
	GMOVERRIDE(PopStyleVar)
	int count = static_cast<int>(YYGetReal(arg, 0));
	ax::NodeEditor::PopStyleVar(count);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins a new NodeEditor frame.
 * @param id The editor identifier.
 * @param width The editor width.
 * @param height The editor height.
 */
GMFUNC(__imext_node_editor_begin) {
	GMOVERRIDE(Begin)
	const char* id = YYGetString(arg, 0);
	float width = static_cast<float>(YYGetReal(arg, 1));
	float height = static_cast<float>(YYGetReal(arg, 2));
	ax::NodeEditor::Begin(
		id,
		ImVec2(width, height)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Ends the current NodeEditor frame.
 */
GMFUNC(__imext_node_editor_end) {
	GMOVERRIDE(End)
	ax::NodeEditor::End();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins a node block.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_begin_node) {
	GMOVERRIDE(BeginNode)
	RValue* node_id = &arg[0];
	ax::NodeEditor::BeginNode(__node_editor_node_id_from_rvalue(node_id));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins a pin block.
 * @param pin_id The pin identifier.
 * @param kind The pin kind (input or output).
 */
GMFUNC(__imext_node_editor_begin_pin) {
	GMOVERRIDE(BeginPin)
	RValue* pin_id = &arg[0];
	double kind = YYGetReal(arg, 1);
	ax::NodeEditor::BeginPin(
		__node_editor_pin_id_from_rvalue(pin_id),
		static_cast<ax::NodeEditor::PinKind>(kind)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Draws a pin rectangle.
 * @param x1 The first X coordinate.
 * @param y1 The first Y coordinate.
 * @param x2 The second X coordinate.
 * @param y2 The second Y coordinate.
 */
GMFUNC(__imext_node_editor_pin_rect) {
	GMOVERRIDE(PinRect)
	int x1 = YYGetReal(arg, 0);
	int y1 = YYGetReal(arg, 1);
	int x2 = YYGetReal(arg, 2);
	int y2 = YYGetReal(arg, 3);
	ImVec2 a(
		static_cast<float>(x1),
		static_cast<float>(y1)
	);
	ImVec2 b(
		static_cast<float>(x2),
		static_cast<float>(y2)
	);
	ax::NodeEditor::PinRect(a, b);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Draws a pivot rectangle for a pin.
 * @param x1 The first X coordinate.
 * @param y1 The first Y coordinate.
 * @param x2 The second X coordinate.
 * @param y2 The second Y coordinate.
 */
GMFUNC(__imext_node_editor_pin_pivot_rect) {
	GMOVERRIDE(PinPivotRect)
	int x1 = YYGetReal(arg, 0);
	int y1 = YYGetReal(arg, 1);
	int x2 = YYGetReal(arg, 2);
	int y2 = YYGetReal(arg, 3);
	ImVec2 a(
		static_cast<float>(x1),
		static_cast<float>(y1)
	);
	ImVec2 b(
		static_cast<float>(x2),
		static_cast<float>(y2)
	);
	ax::NodeEditor::PinPivotRect(a, b);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the pin pivot size.
 * @param width The width.
 * @param height The height.
 */
GMFUNC(__imext_node_editor_pin_pivot_size) {
	GMOVERRIDE(PinPivotSize)
	double width = YYGetReal(arg, 0);
	double height = YYGetReal(arg, 1);
	ax::NodeEditor::PinPivotSize(
		ImVec2(
			static_cast<float>(width),
			static_cast<float>(height)
		)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the pin pivot scale.
 * @param x The X scale.
 * @param y The Y scale.
 */
GMFUNC(__imext_node_editor_pin_pivot_scale) {
	GMOVERRIDE(PinPivotScale)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	ax::NodeEditor::PinPivotScale(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the pin pivot alignment.
 * @param x The X alignment.
 * @param y The Y alignment.
 */
GMFUNC(__imext_node_editor_pin_pivot_alignment) {
	GMOVERRIDE(PinPivotAlignment)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	ax::NodeEditor::PinPivotAlignment(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Ends a pin block.
 */
GMFUNC(__imext_node_editor_end_pin) {
	GMOVERRIDE(EndPin)
	ax::NodeEditor::EndPin();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Draws a group rectangle.
 * @param width The group width.
 * @param height The group height.
 */
GMFUNC(__imext_node_editor_group) {
	GMOVERRIDE(Group)
	double width = YYGetReal(arg, 0);
	double height = YYGetReal(arg, 1);
	ax::NodeEditor::Group(
		ImVec2(
			static_cast<float>(width),
			static_cast<float>(height)
		)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Ends a node block.
 */
GMFUNC(__imext_node_editor_end_node) {
	GMOVERRIDE(EndNode)
	ax::NodeEditor::EndNode();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins a group hint for a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_begin_group_hint) {
	GMOVERRIDE(BeginGroupHint)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::BeginGroupHint(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Returns the minimum X group hint bounds.
 */
GMFUNC(__imext_node_editor_get_group_min) {
	GMOVERRIDE(GetGroupMin)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetGroupMin().x;
}

/**
 * @desc Returns the minimum Y group hint bounds.
 */
GMFUNC(__imext_node_editor_get_group_min_y) {
	GMOVERRIDE(GetGroupMin)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetGroupMin().y;
}

/**
 * @desc Returns the maximum X group hint bounds.
 */
GMFUNC(__imext_node_editor_get_group_max) {
	GMOVERRIDE(GetGroupMax)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetGroupMax().x;
}

/**
 * @desc Returns the maximum Y group hint bounds.
 */
GMFUNC(__imext_node_editor_get_group_max_y) {
	GMOVERRIDE(GetGroupMax)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetGroupMax().y;
}

/**
 * @desc Returns the foreground draw list for the current group hint.
 */
GMFUNC(__imext_node_editor_get_hint_foreground_draw_list) {
	GMOVERRIDE(GetHintForegroundDrawList)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetHintForegroundDrawList();
}

/**
 * @desc Returns the background draw list for the current group hint.
 */
GMFUNC(__imext_node_editor_get_hint_background_draw_list) {
	GMOVERRIDE(GetHintBackgroundDrawList)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetHintBackgroundDrawList();
}

/**
 * @desc Ends the current group hint.
 */
GMFUNC(__imext_node_editor_end_group_hint) {
	GMOVERRIDE(EndGroupHint)
	ax::NodeEditor::EndGroupHint();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the node background draw list for a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_background_draw_list) {
	GMOVERRIDE(GetNodeBackgroundDrawList)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetNodeBackgroundDrawList(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Creates a link between two pins.
 * @param link_id The link identifier.
 * @param start_pin_id The source pin identifier.
 * @param end_pin_id The target pin identifier.
 * @param color A GameMaker color value.
 * @param alpha The alpha component.
 * @param thickness The link thickness.
 */
GMFUNC(__imext_node_editor_link) {
	GMOVERRIDE(Link)
	RValue* link_id = &arg[0];
	RValue* start_pin_id = &arg[1];
	RValue* end_pin_id = &arg[2];
	double col = YYGetReal(arg, 3);
	GMDEFAULT(c_white);
	float alpha = static_cast<float>(YYGetReal(arg, 4));
	GMDEFAULT(1.0);
	float thickness = static_cast<float>(YYGetReal(arg, 5));
	GMDEFAULT(1.0);
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::Link(
		__node_editor_link_id_from_rvalue(link_id),
		__node_editor_pin_id_from_rvalue(start_pin_id),
		__node_editor_pin_id_from_rvalue(end_pin_id),
		GMCOLOR_TO(col, alpha),
		thickness
	);
}

/**
 * @desc Flows a link in a specific direction.
 * @param link_id The link identifier.
 * @param direction The flow direction.
 */
GMFUNC(__imext_node_editor_flow) {
	GMOVERRIDE(Flow)
	RValue* link_id = &arg[0];
	double direction = YYGetReal(arg, 1);
	ax::NodeEditor::Flow(
		__node_editor_link_id_from_rvalue(link_id),
		static_cast<ax::NodeEditor::FlowDirection>(direction)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins creation of a new item.
 * @param color A GameMaker color value.
 * @param alpha The alpha component.
 * @param thickness The item thickness.
 */
GMFUNC(__imext_node_editor_begin_create) {
	GMOVERRIDE(BeginCreate)
	RValue* color = &arg[0];
	GMDEFAULT(undefined);
	float alpha = static_cast<float>(YYGetReal(arg, 1));
	GMDEFAULT(1.0)
	float thickness = static_cast<float>(YYGetReal(arg, 2));
	GMDEFAULT(1.0)

	if (color->kind == VALUE_UNDEFINED) {
		Result.kind = VALUE_BOOL;
		Result.val = ax::NodeEditor::BeginCreate();
	} else {
		Result.kind = VALUE_BOOL;
		Result.val = ax::NodeEditor::BeginCreate(
			GMCOLOR_TO(color->val, alpha),
			thickness
		);
	}
}

/**
 * @desc Queries a new link creation operation.
 * @param result_obj An object of { success, start_pin_id, end_pin_id } that would be updated.
 */
GMFUNC(__imext_node_editor_query_new_link) {
	GMOVERRIDE(QueryNewLink)
	RValue* result_obj = &arg[0];
	GMDEFAULT(undefined)

	GMPREPEND('#arg0 ??= {success:false, start_pin_id:undefined, end_pin_id:undefined};')

	ax::NodeEditor::PinId start = ax::NodeEditor::PinId::Invalid;
    ax::NodeEditor::PinId end   = ax::NodeEditor::PinId::Invalid;

	bool ok = ax::NodeEditor::QueryNewLink(&start, &end);

	if (ok) {
		YYStructAddBool(result_obj, "success", true);
		YYStructAddInt64(result_obj, "start_pin_id", start.Get());
		YYStructAddInt64(result_obj, "end_pin_id", end.Get());
	} else {
		YYStructAddBool(result_obj, "success", false);
		YYStructAddInt64(result_obj, "start_pin_id", -1);
		YYStructAddInt64(result_obj, "end_pin_id", -1);
	}

	Result.kind = VALUE_BOOL;
	Result.val = ok;
	GMRETURNS(Bool);
}


/**
 * @desc Queries a new link creation operation with custom style.
 * @param result_obj An object of { success, start_pin_id, end_pin_id } that will be updated.
 * @param color A GameMaker color value.
 * @param alpha The alpha component.
 * @param thickness The link thickness.
 */
GMFUNC(__imext_node_editor_query_new_link_with_style) {
    GMOVERRIDE(QueryNewLinkWithStyle)
    RValue* result_obj = &arg[0];
    GMDEFAULT(undefined)

    GMPREPEND("#arg0 ??= {success:false, start_pin_id:undefined, end_pin_id:undefined};")

    double color = YYGetReal(arg, 1);
    float alpha = static_cast<float>(YYGetReal(arg, 2));
    float thickness = static_cast<float>(YYGetReal(arg, 3));

    ax::NodeEditor::PinId start = ax::NodeEditor::PinId::Invalid;
    ax::NodeEditor::PinId end   = ax::NodeEditor::PinId::Invalid;

    bool ok = ax::NodeEditor::QueryNewLink(
        &start,
        &end,
        GMCOLOR_TO(color, alpha),
        thickness
    );

    YYStructAddBool(result_obj, "success", ok);
    YYStructAddInt64(result_obj, "start_pin_id", ok ? start.Get() : -1);
    YYStructAddInt64(result_obj, "end_pin_id",   ok ? end.Get()   : -1);

    Result.kind = VALUE_BOOL;
    Result.val = ok;
    GMRETURNS(Bool);
}


/**
 * @desc Queries a new node creation operation.
 */
GMFUNC(__imext_node_editor_query_new_node) {
    GMOVERRIDE(QueryNewNode)

    ax::NodeEditor::PinId pin = ax::NodeEditor::PinId::Invalid;

    bool ok = ax::NodeEditor::QueryNewNode(&pin);

    Result.kind = VALUE_INT64;
    Result.v64 = ok ? pin.Get() : -1;
    GMRETURNS(PinId|Int64);
}


/**
 * @desc Queries a new node creation operation with custom style.
 * @param pin_id Pointer to a pin id that will be filled with the pin.
 * @param color A GameMaker color value.
 * @param alpha The alpha component.
 */
GMFUNC(__imext_node_editor_query_new_node_with_style) {
    GMOVERRIDE(QueryNewNodeWithStyle)

    double color = YYGetReal(arg, 0);
    float alpha = static_cast<float>(YYGetReal(arg, 1));
    float thickness = static_cast<float>(YYGetReal(arg, 2));

    ax::NodeEditor::PinId pin = ax::NodeEditor::PinId::Invalid;

    bool ok = ax::NodeEditor::QueryNewNode(
        &pin,
        GMCOLOR_TO(color, alpha),
        thickness
    );

    Result.kind = VALUE_INT64;
    Result.v64 = ok ? pin.Get() : -1;
    GMRETURNS(PinId|Int64);
}

/**
 * @desc Accepts the current new item operation.
 */
GMFUNC(__imext_node_editor_accept_new_item) {
	GMOVERRIDE(AcceptNewItem)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptNewItem();
}

/**
 * @desc Accepts the current new item operation with custom style.
 */
GMFUNC(__imext_node_editor_accept_new_item_with_style) {
	GMOVERRIDE(AcceptNewItemWithStyle)
	double color = YYGetReal(arg, 0);
	float alpha = static_cast<float>(YYGetReal(arg, 1));
	float thickness = static_cast<float>(YYGetReal(arg, 2));
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptNewItem(
		GMCOLOR_TO(color, alpha),
		thickness
	);
}

/**
 * @desc Rejects the current new item operation.
 */
GMFUNC(__imext_node_editor_reject_new_item) {
	GMOVERRIDE(RejectNewItem)
	ax::NodeEditor::RejectNewItem();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Rejects the current new item operation with custom style.
 */
GMFUNC(__imext_node_editor_reject_new_item_with_style) {
	GMOVERRIDE(RejectNewItemWithStyle)
	double color = YYGetReal(arg, 0);
	float alpha = static_cast<float>(YYGetReal(arg, 1));
	float thickness = static_cast<float>(YYGetReal(arg, 2));
	ax::NodeEditor::RejectNewItem(
		GMCOLOR_TO(color, alpha),
		thickness
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Ends the current item creation operation.
 */
GMFUNC(__imext_node_editor_end_create) {
	GMOVERRIDE(EndCreate)
	ax::NodeEditor::EndCreate();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Begins a delete operation.
 */
GMFUNC(__imext_node_editor_begin_delete) {
	GMOVERRIDE(BeginDelete)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::BeginDelete();
}

/**
 * @desc Queries a deleted link item.
 * @param result_obj An object of { success, link_id, start_pin_id, end_pin_id } that will be updated.
 */
GMFUNC(__imext_node_editor_query_deleted_link) {
    GMOVERRIDE(QueryDeletedLink)
    RValue* result_obj = &arg[0];
    GMDEFAULT(undefined)

    // Ensure the struct exists
    GMPREPEND("#arg0 ??= {success:false, link_id:-1, start_pin_id:-1, end_pin_id:-1};")

    ax::NodeEditor::LinkId link = ax::NodeEditor::LinkId::Invalid;
    ax::NodeEditor::PinId start = ax::NodeEditor::PinId::Invalid;
    ax::NodeEditor::PinId end   = ax::NodeEditor::PinId::Invalid;

    bool ok = ax::NodeEditor::QueryDeletedLink(&link, &start, &end);

    YYStructAddBool(result_obj, "success", ok);
    YYStructAddInt64(result_obj, "link_id",      ok ? link.Get()  : -1);
    YYStructAddInt64(result_obj, "start_pin_id", ok ? start.Get() : -1);
    YYStructAddInt64(result_obj, "end_pin_id",   ok ? end.Get()   : -1);

    Result.kind = VALUE_BOOL;
    Result.val = ok;
    GMRETURNS(Bool);
}

/**
 * @desc Queries a deleted node item.
 */
GMFUNC(__imext_node_editor_query_deleted_node) {
    GMOVERRIDE(QueryDeletedNode)

    ax::NodeEditor::NodeId node = ax::NodeEditor::NodeId::Invalid;

    bool ok = ax::NodeEditor::QueryDeletedNode(&node);

    Result.kind = VALUE_INT64;
    Result.v64 = ok ? node.Get() : -1;
    GMRETURNS(Int64);
}


/**
 * @desc Accepts the current deleted item operation.
 * @param delete_dependencies Whether linked dependencies should also be removed.
 */
GMFUNC(__imext_node_editor_accept_deleted_item) {
	GMOVERRIDE(AcceptDeletedItem)
	bool delete_dependencies = YYGetBool(arg, 0);
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptDeletedItem(delete_dependencies);
}

/**
 * @desc Rejects the current deleted item operation.
 */
GMFUNC(__imext_node_editor_reject_deleted_item) {
	GMOVERRIDE(RejectDeletedItem)
	ax::NodeEditor::RejectDeletedItem();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Ends the current delete operation.
 */
GMFUNC(__imext_node_editor_end_delete) {
	GMOVERRIDE(EndDelete)
	ax::NodeEditor::EndDelete();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets a node position in editor space.
 * @param node_id The node identifier.
 * @param x The X position.
 * @param y The Y position.
 */
GMFUNC(__imext_node_editor_set_node_position) {
	GMOVERRIDE(SetNodePosition)
	RValue* node_id = &arg[0];
	double x = YYGetReal(arg, 1);
	double y = YYGetReal(arg, 2);
	ImVec2 pos(static_cast<float>(x), static_cast<float>(y));
	ax::NodeEditor::SetNodePosition(__node_editor_node_id_from_rvalue(node_id), pos);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets a node group size in editor space.
 * @param node_id The node identifier.
 * @param width The width.
 * @param height The height.
 */
GMFUNC(__imext_node_editor_set_group_size) {
	GMOVERRIDE(SetGroupSize)
	RValue* node_id = &arg[0];
	double width = YYGetReal(arg, 1);
	double height = YYGetReal(arg, 2);
	ax::NodeEditor::SetGroupSize(
		__node_editor_node_id_from_rvalue(node_id),
		ImVec2(
			static_cast<float>(width),
			static_cast<float>(height)
		)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the X position of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_position) {
	GMOVERRIDE(GetNodePosition)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodePosition(__node_editor_node_id_from_rvalue(node_id)).x;
}

/**
 * @desc Returns the Y position of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_position_y) {
	GMOVERRIDE(GetNodePosition)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodePosition(__node_editor_node_id_from_rvalue(node_id)).y;
}

/**
 * @desc Returns the width of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_size) {
	GMOVERRIDE(GetNodeSize)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodeSize(__node_editor_node_id_from_rvalue(node_id)).x;
}

/**
 * @desc Returns the height of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_size_y) {
	GMOVERRIDE(GetNodeSize)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodeSize(__node_editor_node_id_from_rvalue(node_id)).y;
}

/**
 * @desc Centers a node on screen.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_center_node_on_screen) {
	GMOVERRIDE(CenterNodeOnScreen)
	RValue* node_id = &arg[0];
	ax::NodeEditor::CenterNodeOnScreen(__node_editor_node_id_from_rvalue(node_id));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the z-position for a node.
 * @param node_id The node identifier.
 * @param z The z-position.
 */
GMFUNC(__imext_node_editor_set_node_z_position) {
	GMOVERRIDE(SetNodeZPosition)
	RValue* node_id = &arg[0];
	double z = YYGetReal(arg, 1);
	ax::NodeEditor::SetNodeZPosition(
		__node_editor_node_id_from_rvalue(node_id),
		static_cast<float>(z)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the z-position of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_get_node_z_position) {
	GMOVERRIDE(GetNodeZPosition)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodeZPosition(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Restores the saved state of a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_restore_node_state) {
	GMOVERRIDE(RestoreNodeState)
	RValue* node_id = &arg[0];
	ax::NodeEditor::RestoreNodeState(__node_editor_node_id_from_rvalue(node_id));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Suspends the editor interaction flow.
 */
GMFUNC(__imext_node_editor_suspend) {
	GMOVERRIDE(Suspend)
	ax::NodeEditor::Suspend();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Resumes the editor interaction flow.
 */
GMFUNC(__imext_node_editor_resume) {
	GMOVERRIDE(Resume)
	ax::NodeEditor::Resume();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns whether the editor is currently suspended.
 */
GMFUNC(__imext_node_editor_is_suspended) {
	GMOVERRIDE(IsSuspended)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsSuspended();
}

/**
 * @desc Returns whether the editor is active.
 */
GMFUNC(__imext_node_editor_is_active) {
	GMOVERRIDE(IsActive)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsActive();
}

/**
 * @desc Returns whether the selection state changed this frame.
 */
GMFUNC(__imext_node_editor_has_selection_changed) {
	GMOVERRIDE(HasSelectionChanged)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::HasSelectionChanged();
}

/**
 * @desc Returns the number of selected objects.
 */
GMFUNC(__imext_node_editor_get_selected_object_count) {
	GMOVERRIDE(GetSelectedObjectCount)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetSelectedObjectCount();
}

/**
 * @desc Returns the number of selected nodes.
 */
GMFUNC(__imext_node_editor_get_selected_nodes) {
	GMOVERRIDE(GetSelectedNodes)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetSelectedNodes(nullptr, 0);
}

/**
 * @desc Returns the number of selected links.
 */
GMFUNC(__imext_node_editor_get_selected_links) {
	GMOVERRIDE(GetSelectedLinks)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetSelectedLinks(nullptr, 0);
}

/**
 * @desc Returns whether a node is selected.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_is_node_selected) {
	GMOVERRIDE(IsNodeSelected)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsNodeSelected(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Returns whether a link is selected.
 * @param link_id The link identifier.
 */
GMFUNC(__imext_node_editor_is_link_selected) {
	GMOVERRIDE(IsLinkSelected)
	RValue* link_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsLinkSelected(__node_editor_link_id_from_rvalue(link_id));
}

/**
 * @desc Clears the current selection.
 */
GMFUNC(__imext_node_editor_clear_selection) {
	GMOVERRIDE(ClearSelection)
	ax::NodeEditor::ClearSelection();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Selects a node.
 * @param node_id The node identifier.
 * @param append Whether to append to the current selection.
 */
GMFUNC(__imext_node_editor_select_node) {
	GMOVERRIDE(SelectNode)
	RValue* node_id = &arg[0];
	bool append = YYGetBool(arg, 1);
	ax::NodeEditor::SelectNode(
		__node_editor_node_id_from_rvalue(node_id),
		append
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Selects a link.
 * @param link_id The link identifier.
 * @param append Whether to append to the current selection.
 */
GMFUNC(__imext_node_editor_select_link) {
	GMOVERRIDE(SelectLink)
	RValue* link_id = &arg[0];
	bool append = YYGetBool(arg, 1);
	ax::NodeEditor::SelectLink(
		__node_editor_link_id_from_rvalue(link_id),
		append
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Deselects a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_deselect_node) {
	GMOVERRIDE(DeselectNode)
	RValue* node_id = &arg[0];
	ax::NodeEditor::DeselectNode(__node_editor_node_id_from_rvalue(node_id));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Deselects a link.
 * @param link_id The link identifier.
 */
GMFUNC(__imext_node_editor_deselect_link) {
	GMOVERRIDE(DeselectLink)
	RValue* link_id = &arg[0];
	ax::NodeEditor::DeselectLink(__node_editor_link_id_from_rvalue(link_id));
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Deletes a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_delete_node) {
	GMOVERRIDE(DeleteNode)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::DeleteNode(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Deletes a link.
 * @param link_id The link identifier.
 */
GMFUNC(__imext_node_editor_delete_link) {
	GMOVERRIDE(DeleteLink)
	RValue* link_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::DeleteLink(__node_editor_link_id_from_rvalue(link_id));
}

/**
 * @desc Returns whether a node has any links.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_has_any_links_node) {
	GMOVERRIDE(HasAnyLinks)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::HasAnyLinks(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Returns whether a pin has any links.
 * @param pin_id The pin identifier.
 */
GMFUNC(__imext_node_editor_has_any_links_pin) {
	GMOVERRIDE(HasAnyLinks)
	RValue* pin_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::HasAnyLinks(__node_editor_pin_id_from_rvalue(pin_id));
}

/**
 * @desc Breaks all links connected to a node.
 * @param node_id The node identifier.
 */
GMFUNC(__imext_node_editor_break_links_node) {
	GMOVERRIDE(BreakLinks)
	RValue* node_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::BreakLinks(__node_editor_node_id_from_rvalue(node_id));
}

/**
 * @desc Breaks all links connected to a pin.
 * @param pin_id The pin identifier.
 */
GMFUNC(__imext_node_editor_break_links_pin) {
	GMOVERRIDE(BreakLinks)
	RValue* pin_id = &arg[0];
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::BreakLinks(__node_editor_pin_id_from_rvalue(pin_id));
}

/**
 * @desc Navigates the editor view to its content.
 * @param duration The navigation duration in seconds.
 */
GMFUNC(__imext_node_editor_navigate_to_content) {
	GMOVERRIDE(NavigateToContent)
	double duration = YYGetReal(arg, 0);
	ax::NodeEditor::NavigateToContent(
		static_cast<float>(duration)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Navigates the editor view to the current selection.
 * @param zoom_in Whether to zoom in.
 * @param duration The navigation duration in seconds.
 */
GMFUNC(__imext_node_editor_navigate_to_selection) {
	GMOVERRIDE(NavigateToSelection)
	bool zoom_in = YYGetBool(arg, 0);
	double duration = YYGetReal(arg, 1);
	ax::NodeEditor::NavigateToSelection(
		zoom_in,
		static_cast<float>(duration)
	);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Shows the node context menu and returns whether a node was selected.
 * @param node_id Optional output node id.
 */
GMFUNC(__imext_node_editor_show_node_context_menu) {
	GMOVERRIDE(ShowNodeContextMenu)
	ax::NodeEditor::NodeId node_id = ax::NodeEditor::NodeId::Invalid;
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::ShowNodeContextMenu(&node_id);
}

/**
 * @desc Shows the pin context menu and returns whether a pin was selected.
 * @param pin_id Optional output pin id.
 */
GMFUNC(__imext_node_editor_show_pin_context_menu) {
	GMOVERRIDE(ShowPinContextMenu)
	ax::NodeEditor::PinId pin_id = ax::NodeEditor::PinId::Invalid;
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::ShowPinContextMenu(&pin_id);
}

/**
 * @desc Shows the link context menu and returns whether a link was selected.
 * @param link_id Optional output link id.
 */
GMFUNC(__imext_node_editor_show_link_context_menu) {
	GMOVERRIDE(ShowLinkContextMenu)
	ax::NodeEditor::LinkId link_id = ax::NodeEditor::LinkId::Invalid;
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::ShowLinkContextMenu(&link_id);
}

/**
 * @desc Shows the background context menu.
 */
GMFUNC(__imext_node_editor_show_background_context_menu) {
	GMOVERRIDE(ShowBackgroundContextMenu)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::ShowBackgroundContextMenu();
}

/**
 * @desc Enables or disables editor shortcuts.
 * @param enable Whether shortcuts should be enabled.
 */
GMFUNC(__imext_node_editor_enable_shortcuts) {
	GMOVERRIDE(EnableShortcuts)
	bool enable = YYGetBool(arg, 0);
	ax::NodeEditor::EnableShortcuts(enable);
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns whether shortcuts are currently enabled.
 */
GMFUNC(__imext_node_editor_are_shortcuts_enabled) {
	GMOVERRIDE(AreShortcutsEnabled)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AreShortcutsEnabled();
}

/**
 * @desc Begins a shortcut interaction block.
 */
GMFUNC(__imext_node_editor_begin_shortcut) {
	GMOVERRIDE(BeginShortcut)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::BeginShortcut();
}

/**
 * @desc Accepts a cut action during a shortcut interaction.
 */
GMFUNC(__imext_node_editor_accept_cut) {
	GMOVERRIDE(AcceptCut)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptCut();
}

/**
 * @desc Accepts a copy action during a shortcut interaction.
 */
GMFUNC(__imext_node_editor_accept_copy) {
	GMOVERRIDE(AcceptCopy)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptCopy();
}

/**
 * @desc Accepts a paste action during a shortcut interaction.
 */
GMFUNC(__imext_node_editor_accept_paste) {
	GMOVERRIDE(AcceptPaste)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptPaste();
}

/**
 * @desc Accepts a duplicate action during a shortcut interaction.
 */
GMFUNC(__imext_node_editor_accept_duplicate) {
	GMOVERRIDE(AcceptDuplicate)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptDuplicate();
}

/**
 * @desc Accepts a create-node action during a shortcut interaction.
 */
GMFUNC(__imext_node_editor_accept_create_node) {
	GMOVERRIDE(AcceptCreateNode)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::AcceptCreateNode();
}

/**
 * @desc Returns the size of the current action context.
 */
GMFUNC(__imext_node_editor_get_action_context_size) {
	GMOVERRIDE(GetActionContextSize)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetActionContextSize();
}

/**
 * @desc Returns the node ids in the current action context.
 */
GMFUNC(__imext_node_editor_get_action_context_nodes) {
	GMOVERRIDE(GetActionContextNodes)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetActionContextNodes(nullptr, 0);
}

/**
 * @desc Returns the link ids in the current action context.
 */
GMFUNC(__imext_node_editor_get_action_context_links) {
	GMOVERRIDE(GetActionContextLinks)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetActionContextLinks(nullptr, 0);
}

/**
 * @desc Ends a shortcut interaction block.
 */
GMFUNC(__imext_node_editor_end_shortcut) {
	GMOVERRIDE(EndShortcut)
	ax::NodeEditor::EndShortcut();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the current zoom level.
 */
GMFUNC(__imext_node_editor_get_current_zoom) {
	GMOVERRIDE(GetCurrentZoom)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetCurrentZoom();
}

/**
 * @desc Returns the node currently hovered by the mouse.
 */
GMFUNC(__imext_node_editor_get_hovered_node) {
	GMOVERRIDE(GetHoveredNode)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetHoveredNode().AsPointer();
}

/**
 * @desc Returns the pin currently hovered by the mouse.
 */
GMFUNC(__imext_node_editor_get_hovered_pin) {
	GMOVERRIDE(GetHoveredPin)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetHoveredPin().AsPointer();
}

/**
 * @desc Returns the link currently hovered by the mouse.
 */
GMFUNC(__imext_node_editor_get_hovered_link) {
	GMOVERRIDE(GetHoveredLink)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetHoveredLink().AsPointer();
}

/**
 * @desc Returns the node that was double-clicked.
 */
GMFUNC(__imext_node_editor_get_double_clicked_node) {
	GMOVERRIDE(GetDoubleClickedNode)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetDoubleClickedNode().AsPointer();
}

/**
 * @desc Returns the pin that was double-clicked.
 */
GMFUNC(__imext_node_editor_get_double_clicked_pin) {
	GMOVERRIDE(GetDoubleClickedPin)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetDoubleClickedPin().AsPointer();
}

/**
 * @desc Returns the link that was double-clicked.
 */
GMFUNC(__imext_node_editor_get_double_clicked_link) {
	GMOVERRIDE(GetDoubleClickedLink)
	Result.kind = VALUE_PTR;
	Result.ptr = ax::NodeEditor::GetDoubleClickedLink().AsPointer();
}

/**
 * @desc Returns whether the background was clicked.
 */
GMFUNC(__imext_node_editor_is_background_clicked) {
	GMOVERRIDE(IsBackgroundClicked)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsBackgroundClicked();
}

/**
 * @desc Returns whether the background was double-clicked.
 */
GMFUNC(__imext_node_editor_is_background_double_clicked) {
	GMOVERRIDE(IsBackgroundDoubleClicked)
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::IsBackgroundDoubleClicked();
}

/**
 * @desc Returns the button index used for a background click.
 */
GMFUNC(__imext_node_editor_get_background_click_button_index) {
	GMOVERRIDE(GetBackgroundClickButtonIndex)
	Result.kind = VALUE_REAL;
	Result.val = static_cast<double>(ax::NodeEditor::GetBackgroundClickButtonIndex());
}

/**
 * @desc Returns the button index used for a background double-click.
 */
GMFUNC(__imext_node_editor_get_background_double_click_button_index) {
	GMOVERRIDE(GetBackgroundDoubleClickButtonIndex)
	Result.kind = VALUE_REAL;
	Result.val = static_cast<double>(ax::NodeEditor::GetBackgroundDoubleClickButtonIndex());
}

/**
 * @desc Returns the start and end pins for a link.
 * @param link_id The link identifier.
 */
GMFUNC(__imext_node_editor_get_link_pins) {
	GMOVERRIDE(GetLinkPins)
	RValue* link_id = &arg[0];
	ax::NodeEditor::PinId start_pin_id = ax::NodeEditor::PinId::Invalid;
	ax::NodeEditor::PinId end_pin_id = ax::NodeEditor::PinId::Invalid;
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::GetLinkPins(__node_editor_link_id_from_rvalue(link_id), &start_pin_id, &end_pin_id);
}

/**
 * @desc Returns whether a pin had any links.
 * @param pin_id The pin identifier.
 */
GMFUNC(__imext_node_editor_pin_had_any_links) {
	GMOVERRIDE(PinHadAnyLinks)
	RValue* pin_id = &arg[0];
	Result.kind = VALUE_BOOL;
	Result.val = ax::NodeEditor::PinHadAnyLinks(__node_editor_pin_id_from_rvalue(pin_id));
}

/**
 * @desc Returns the screen width of the editor canvas.
 */
GMFUNC(__imext_node_editor_get_screen_size) {
	GMOVERRIDE(GetScreenSize)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetScreenSize().x;
}

/**
 * @desc Returns the screen height of the editor canvas.
 */
GMFUNC(__imext_node_editor_get_screen_size_y) {
	GMOVERRIDE(GetScreenSize)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetScreenSize().y;
}

/**
 * @desc Converts a screen-space X position to canvas-space.
 * @param x The X coordinate.
 * @param y The Y coordinate.
 */
GMFUNC(__imext_node_editor_screen_to_canvas) {
	GMOVERRIDE(ScreenToCanvas)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::ScreenToCanvas(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	).x;
}

/**
 * @desc Converts a screen-space Y position to canvas-space.
 * @param x The X coordinate.
 * @param y The Y coordinate.
 */
GMFUNC(__imext_node_editor_screen_to_canvas_y) {
	GMOVERRIDE(ScreenToCanvas)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::ScreenToCanvas(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	).y;
}

/**
 * @desc Converts a canvas-space X position to screen-space.
 * @param x The X coordinate.
 * @param y The Y coordinate.
 */
GMFUNC(__imext_node_editor_canvas_to_screen) {
	GMOVERRIDE(CanvasToScreen)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::CanvasToScreen(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	).x;
}

/**
 * @desc Converts a canvas-space Y position to screen-space.
 * @param x The X coordinate.
 * @param y The Y coordinate.
 */
GMFUNC(__imext_node_editor_canvas_to_screen_y) {
	GMOVERRIDE(CanvasToScreen)
	double x = YYGetReal(arg, 0);
	double y = YYGetReal(arg, 1);
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::CanvasToScreen(
		ImVec2(
			static_cast<float>(x),
			static_cast<float>(y)
		)
	).y;
}

/**
 * @desc Returns the number of submitted nodes since the current Begin call.
 */
GMFUNC(__imext_node_editor_get_node_count) {
	GMOVERRIDE(GetNodeCount)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetNodeCount();
}

/**
 * @desc Returns a list of ordered node IDs for the current frame.
 */
GMFUNC(__imext_node_editor_get_ordered_node_ids) {
	GMOVERRIDE(GetOrderedNodeIds)
	Result.kind = VALUE_REAL;
	Result.val = ax::NodeEditor::GetOrderedNodeIds(nullptr, 0);
}

