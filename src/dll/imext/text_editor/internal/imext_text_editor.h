// A header file used by the tools wrappers:gen

#pragma once
#include "./imgui_text_editor.h"

enum ImTextEditorPalette_ : int32_t
{
    ImTextEditorPalette_Dark		= 0,
    ImTextEditorPalette_Light		= 1,
    ImTextEditorPalette_RetroBlue	= 2,
    ImTextEditorPalette_GameMaker	= 3,
};

enum ImTextEditorLanguage_ : int32_t
{
    ImTextEditorLanguage_CPlusPlus  = 0,
    ImTextEditorLanguage_HLSL       = 1,
    ImTextEditorLanguage_GLSL       = 2,
    ImTextEditorLanguage_Lua        = 3,
    ImTextEditorLanguage_GML        = 4,
};