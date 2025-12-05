#include <imgm.h>
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
 * @desc Adds a font from a TTF file on disk.
 *
 * @param file The path to the TTF file.
 * @param size_pixels The font size in pixels.
 * @param glyph_ranges An optional flat array of unicode pairs [start,end...] ending with an optional terminating-zero element.
 *
 *
 * e.g. Some characters for Arabic: [$0600, $06FF, $0750, $077F, 0]
 *
 */
GMFUNC(__imgui_add_font_from_file_TTF) {
    GMOVERRIDE(AddFontFromFileTTF);
    const char* file = YYGetString(arg, 0);
    float size_pixels = (float)YYGetReal(arg, 1);
    RValue* font_cfg = &arg[2];
	GMDEFAULT(undefined)
    GMHINT(ImFontConfig);

    RValue* glyph_ranges = &arg[3];
    GMDEFAULT(undefined)
    GMHINT(Array<Real>)

    double glyph_ranges_count = YYGetReal(arg, 4);
    GMHIDDEN();
    GMPASSTHROUGH(array_length(#arg3));

    ImWchar* final_glyph_ranges = nullptr;
    if (glyph_ranges->kind != VALUE_UNDEFINED) {
        final_glyph_ranges = YYGetArray<ImWchar>(arg, 3, glyph_ranges_count);
    }
    ImFontConfig* final_font_cfg = nullptr;
    if (font_cfg->kind != VALUE_UNDEFINED) {
        final_font_cfg = ImGuiFontConfigFromStruct(font_cfg);
    }

    ImGuiIO& io = ImGui::GetIO();
    ImFont* font = io.Fonts->AddFontFromFileTTF(file, size_pixels, final_font_cfg, final_glyph_ranges);

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

/**
 * @desc Adds a font from a GameMaker buffer of TTF font file contents and calls `ImGui.AddFontFromMemoryTTF`
 *
 * @param ttf_buffer A GameMaker buffer containing the TTF font data.
 * @param size_pixels The font size in pixels.
 * @param glyph_ranges An optional flat array of unicode pairs [start,end...] ending with an optional terminating-zero element.
 * e.g. Some characters for Arabic: [$0600, $06FF, $0750, $077F, 0]
 *
 * @todo Test if buffer is destroyed afterwards as per ImGui docs.
 *
 */
GMFUNC(__imgui_add_font_from_buffer) {
    // dear ImGui "will take ownership of the data and free the pointer on destruction."

    GMOVERRIDE(AddFontFromBuffer);
	GMPREPEND("");
    int ttf_buffer = (int)YYGetReal(arg, 0);
    GMHINT(Id.Buffer);
    float size_pixels = (float)YYGetReal(arg, 1);
    RValue* font_cfg = &arg[2];
	GMDEFAULT(undefined)
    GMHINT(ImFontConfig);

    RValue* glyph_ranges = &arg[3];
    GMDEFAULT(undefined)
    GMHINT(Array<Real>)

    double glyph_ranges_count = YYGetReal(arg, 4);
    GMHIDDEN();
    GMPASSTHROUGH(array_length(#arg3));

    int ttf_buffer_size = (int)YYGetReal(arg, 5);
    GMHIDDEN();
    GMPASSTHROUGH(buffer_get_size(#arg0));

    ImWchar* final_glyph_ranges = nullptr;
    if (glyph_ranges->kind != VALUE_UNDEFINED) {
        final_glyph_ranges = YYGetArray<ImWchar>(arg, 3, glyph_ranges_count);
    }
    ImFontConfig* final_font_cfg = nullptr;
    if (font_cfg->kind != VALUE_UNDEFINED) {
        final_font_cfg = ImGuiFontConfigFromStruct(font_cfg);
    }

    ImGuiIO& io = ImGui::GetIO();

    void* ttf_buffer_data;
    bool success = BufferGetContent(ttf_buffer, &ttf_buffer_data, &ttf_buffer_size);

    Result.kind = VALUE_UNDEFINED;
    if (success) {
        // TODO: maybe use: ttf_buffer_size = (static_cast<size_t>(ttf_buffer_size));
        ImFont* font = io.Fonts->AddFontFromMemoryTTF(ttf_buffer_data, ttf_buffer_size, size_pixels, final_font_cfg, final_glyph_ranges);

        if (font) {
            g_UpdateFont = true;
            Result.kind = VALUE_PTR;
            Result.ptr = font;
        }
    }

    GMRETURNS(Pointer|Undefined);
}

GMFUNC(__imgui_get_font_size) {
	Result.kind = VALUE_REAL;
	Result.val = ImGui::GetFontSize();
}
