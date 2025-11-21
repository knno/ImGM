#include "../imgm.h"

GMFUNC(__imgui_begin_list_box) {
	const char* label = YYGetString(arg, 0);
	double width = YYGetReal(arg, 1);
	GMDEFAULT(0);
	double height = YYGetReal(arg, 2);
	GMDEFAULT(0);

	Result.kind = VALUE_BOOL;
	Result.val = ImGui::BeginListBox(label, ImVec2(width, height));
}

GMFUNC(__imgui_end_list_box) {
	Result.kind = VALUE_UNDEFINED;
	ImGui::EndListBox();
}

GMFUNC(__imgui_list_box) {
	GMOVERRIDE(ListBox);
	ShowError("Unimplemented ImGui Function: ImGui.ListBox");
}