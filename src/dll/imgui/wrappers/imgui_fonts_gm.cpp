#include "../imgm.h"
#include "imgui_gm_fontconfig.h"

GMFUNC(__imgui_get_font) {
	Result.kind = VALUE_PTR;
	Result.ptr = ImGui::GetFont();
}

GMFUNC(__imgui_push_font) {
	RValue* ptr = &arg[0];
	GMDEFAULT(undefined);

	Result.kind = VALUE_UNDEFINED;
	if (ptr->kind == VALUE_UNDEFINED) {
		ImGui::PushFont(NULL);
		return;
	}
	ImGui::PushFont((ImFont*)ptr->ptr);
}

GMFUNC(__imgui_pop_font) {
	ImGui::PopFont();
	Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc glyph_ranges is a flat array of unicode start,end and a terminating zero value.
 * e.g. For Arabic: [$0600, $06FF, $0750, $077F, 0]
 *
 */
GMFUNC(__imgui_add_font_from_file_TTF) {
    GMOVERRIDE(AddFontFromFileTTF);
    const char* file = YYGetString(arg, 0);
    float size = (float)YYGetReal(arg, 1);
    RValue* font_cfg = &arg[2];
	GMDEFAULT(undefined)
    GMHINT(ImFontConfig);

    double glyph_ranges_count = YYGetReal(arg, 4);
    GMHIDDEN();
    GMPASSTHROUGH(array_length(#arg3));
    RValue* glyph_ranges = &arg[3];
    GMDEFAULT(undefined)
    GMHINT(Array<Real>)

    ImWchar* final_glyph_ranges = nullptr;
    if (glyph_ranges->kind != VALUE_UNDEFINED) {
        final_glyph_ranges = YYGetArray<ImWchar>(arg, 3, glyph_ranges_count);
    }
    ImFontConfig* final_font_cfg = nullptr;
    if (font_cfg->kind != VALUE_UNDEFINED) {
        final_font_cfg = ImGuiFontConfigFromStruct(font_cfg);
    }

    ImGuiIO& io = ImGui::GetIO();
    ImFont* font = io.Fonts->AddFontFromFileTTF(file, size, final_font_cfg, final_glyph_ranges);

    if (font) {
        g_UpdateFont = true;
        Result.kind = VALUE_PTR;
        Result.ptr = font;
    } else {
        Result.kind = VALUE_UNDEFINED;
    }

    GMRETURNS(Pointer|Undefined);
}

GMFUNC(__imgui_add_font_default) {
	ImGuiIO& io = ImGui::GetIO();

	if (ImFont* font = io.Fonts->AddFontDefault()) {
		g_UpdateFont = true;
		Result.kind = VALUE_PTR;
		Result.ptr = font;
	} else {
		Result.kind = VALUE_UNDEFINED;
	}

	GMRETURNS(Pointer|Undefined);
}

GMFUNC(__imgui_get_font_size) {
	Result.kind = VALUE_REAL;
	Result.val = ImGui::GetFontSize();
}
