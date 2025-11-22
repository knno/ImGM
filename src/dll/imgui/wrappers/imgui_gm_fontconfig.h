#pragma once
#include "imgm.h"

static ImFontConfig* ImGuiFontConfigFromStruct(RValue* yystruct) {
    // Always allocate a fresh config
    ImFontConfig* cfg = IM_NEW(ImFontConfig);

    // Initialize with defaults
    *cfg = ImFontConfig();

    if (yystruct->kind != VALUE_UNDEFINED) {
        RValue* rvalue;

        // Basics
        rvalue = YYStructGetMember(yystruct, "SizePixels");
        AssignIfDefinedElse(rvalue, cfg->SizePixels, RConvertToReal, 0.0f);

        rvalue = YYStructGetMember(yystruct, "OversampleH");
        AssignIfDefinedElse(rvalue, cfg->OversampleH, RConvertToReal, 3);

        rvalue = YYStructGetMember(yystruct, "OversampleV");
        AssignIfDefinedElse(rvalue, cfg->OversampleV, RConvertToInt, 1);

        rvalue = YYStructGetMember(yystruct, "PixelSnapH");
        AssignIfDefinedElse(rvalue, cfg->PixelSnapH, RConvertToBool, false);

        rvalue = YYStructGetMember(yystruct, "GlyphExtraAdvanceX");
        AssignIfDefinedElse(rvalue, cfg->GlyphExtraAdvanceX, RConvertToReal, 0.0f);

        rvalue = YYStructGetMember(yystruct, "GlyphOffsetX");
        AssignIfDefinedElse(rvalue, cfg->GlyphOffset.x, RConvertToReal, 0.0f);

        rvalue = YYStructGetMember(yystruct, "GlyphOffsetY");
        AssignIfDefinedElse(rvalue, cfg->GlyphOffset.y, RConvertToReal, 0.0f);

        rvalue = YYStructGetMember(yystruct, "MergeMode");
        AssignIfDefinedElse(rvalue, cfg->MergeMode, RConvertToBool, false);

        rvalue = YYStructGetMember(yystruct, "FontDataOwnedByAtlas");
        AssignIfDefinedElse(rvalue, cfg->FontDataOwnedByAtlas, RConvertToBool, true);

        rvalue = YYStructGetMember(yystruct, "RasterizerMultiply");
        AssignIfDefinedElse(rvalue, cfg->RasterizerMultiply, RConvertToReal, 1.0f);

        rvalue = YYStructGetMember(yystruct, "EllipsisChar");
        AssignIfDefinedElse(rvalue, cfg->EllipsisChar, RConvertToInt, (ImWchar)-1);

        rvalue = YYStructGetMember(yystruct, "GlyphMinAdvanceX");
        AssignIfDefinedElse(rvalue, cfg->GlyphMinAdvanceX, RConvertToReal, 0.0f);

        rvalue = YYStructGetMember(yystruct, "GlyphMaxAdvanceX");
        AssignIfDefinedElse(rvalue, cfg->GlyphMaxAdvanceX, RConvertToReal, FLT_MAX);

        rvalue = YYStructGetMember(yystruct, "FontLoaderFlags");
        AssignIfDefinedElse(rvalue, cfg->FontLoaderFlags, RConvertToUInt, 0);
    }

    return cfg;
}
