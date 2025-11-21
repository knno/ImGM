#include "../imgm.h"

GMFUNC(__imgui_begin_combo) {
	const char* label = YYGetString(arg, 0);
	const char* preview = YYGetString(arg, 1);
	ImGuiComboFlags flags = (int)YYGetReal(arg, 2);

	Result.kind = VALUE_BOOL;
	Result.val = ImGui::BeginCombo(label, preview, flags);
}

GMFUNC(__imgui_end_combo) {
	ImGui::EndCombo();
	Result.kind = VALUE_UNDEFINED;
}

GMFUNC(__imgui_combo) {
	GMOVERRIDE(Combo);
	ShowError("Unimplemented ImGui Function: ImGui.Combo");
}