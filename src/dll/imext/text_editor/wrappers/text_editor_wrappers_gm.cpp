/// This file is originally written by TrashBash <github.com/TrashBash>

#include "../internal/imgui_text_editor_utils.cpp"
#include "../internal/imgui_text_editor.h"
#include "../internal/imext_text_editor.h"

// @ PUBLIC API

GMFUNC(__imext_text_editor_create)
{
	auto* _editor = new TextEditor();
	int32_t _handle;

	// Check if we can reuse an ID from the free list
	if (!FREE_IDS.empty())
	{
		// Get last recylced ID and remove it from list
		_handle = FREE_IDS.back();
		FREE_IDS.pop_back();
	}
	else
		_handle = NEXT_ID++;

	EDITORS[_handle] = _editor;
	__return_i32(Result, _handle);

	GMRETURNS(Real)
}

GMFUNC(__imext_text_editor_destroy)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	auto _entry = EDITORS.find(_handle);
	if (_entry != EDITORS.end())
	{
		// Free TextEditor memory and remove from active map
		delete _entry->second;
		EDITORS.erase(_entry);

		// Add ID to free list for recycling
		FREE_IDS.push_back(_handle);
	}
}

GMFUNC(__imext_text_editor_cleanup)
{
	// Delete any remaining editors
	for (auto const& item : EDITORS)
	{
		// Free memory
		delete item.second;
	}

	// Clear containers
	EDITORS.clear();
	FREE_IDS.clear();
	NEXT_ID = 0;

	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_set_text)
{
	const char* _text 	= YYGetString(arg, 0);
	int32_t _handle		= YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SetText(_text ? _text : "");
}

GMFUNC(__imext_text_editor_get_text)
{
	int32_t _handle	= YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_STRING;

	__return_string(Result, _editor->GetText());
	GMRETURNS(String)
}

GMFUNC(__imext_text_editor_set_language)
{
	int32_t _languageID	= YYGetInt32(arg, 0);	GMDEFAULT(0);
	int32_t _handle		= YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	switch (_languageID)
	{
		case ImTextEditorLanguage_CPlusPlus: _editor->SetLanguageDefinition(TextEditor::LanguageDefinition::CPlusPlus());	break;
		case ImTextEditorLanguage_HLSL: _editor->SetLanguageDefinition(TextEditor::LanguageDefinition::HLSL());			break;
		case ImTextEditorLanguage_GLSL: _editor->SetLanguageDefinition(TextEditor::LanguageDefinition::GLSL());			break;
		case ImTextEditorLanguage_Lua: _editor->SetLanguageDefinition(TextEditor::LanguageDefinition::Lua());			break;
		case ImTextEditorLanguage_GML: _editor->SetLanguageDefinition(TextEditor::LanguageDefinition::GML());			break;
		default:
			break;
	}

	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_render)
{
	double _width			= YYGetReal(arg, 0);	GMDEFAULT(0);
	double _height			= YYGetReal(arg, 1);	GMDEFAULT(0);
	ImGuiChildFlags _flags	= YYGetInt64(arg, 2);	GMDEFAULT(0);

	int32_t _handle			= YYGetInt32(arg, 3);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)
	const char* _title		= YYGetString(arg, 4);
	GMHIDDEN();
	GMPASSTHROUGH(self.title)

	CHECK_EDITOR_BOOL;

	_editor->Render(_title, ImVec2(_width, _height), _flags);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_is_read_only)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->IsReadOnly());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_set_read_only)
{
	bool _readOnly	= YYGetBool(arg, 0);

	int32_t _handle	= YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SetReadOnly(_readOnly);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_is_text_modified)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->IsTextChanged());
	GMRETURNS(Bool)
}

// @ LINES / POSITIONS / SELECTION

GMFUNC(__imext_text_editor_has_selection)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->HasSelection());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_select_all)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SelectAll();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_select_word_under_cursor)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SelectWordUnderCursor();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_select_line)
{
	int64_t _line	= YYGetInt64(arg, 0);
	int32_t _handle = YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_line = max(0, _line - 1);
	TextEditor::Coordinates _start, _end;

	_start.mLine	= _line;
	_start.mColumn	= 0;

	_end.mLine		= _line;
	_end.mColumn	= 0;

	_editor->SetSelection(_start, _end, TextEditor::SelectionMode::Line);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_get_selected_text)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_string(Result, _editor->GetSelectedText());
	GMRETURNS(String)
}

GMFUNC(__imext_text_editor_set_cursor_pos_line_column)
{
	GMOVERRIDE(SetCursorPosition)
	int64_t _line	= YYGetInt64(arg, 0);	GMDEFAULT(1);
	int64_t _column = YYGetInt64(arg, 1);	GMDEFAULT(1);
	int32_t _handle = YYGetInt32(arg, 2);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	// 1-based index
	_editor->SetCursorPosition(TextEditor::Coordinates(_line - 1, _column - 1));
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_get_cursor_pos_line)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	auto _coordinates = _editor->GetCursorPosition();

	// Convert to 1-based index for GML
	__return_i64(Result, _coordinates.mLine + 1);
	GMRETURNS(Real)
}

GMFUNC(__imext_text_editor_get_cursor_pos_column)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	auto _coordinates = _editor->GetCursorPosition();

	// Convert to 1-based index for GML
	__return_i64(Result, _coordinates.mColumn + 1);
	GMRETURNS(Real)
}

GMFUNC(__imext_text_editor_get_total_lines)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_i64(Result, _editor->GetTotalLines());
	GMRETURNS(Real)
}

// @ UNDO / REDO

GMFUNC(__imext_text_editor_can_undo)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->CanUndo());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_can_redo)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->CanRedo());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_undo)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Undo();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_redo)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Redo();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

// @ CLIPBOARD / EDIT OPERATIONS

GMFUNC(__imext_text_editor_is_overwrite)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->IsOverwrite());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_copy)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Copy();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_paste)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Paste();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_cut)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Cut();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_delete)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->Delete();
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_insert_text)
{
	int32_t _handle		= YYGetInt32(arg, 0);
	const char* _text	= YYGetString(arg, 1);

	CHECK_EDITOR_BOOL;

	_editor->InsertText(_text ? _text : "");
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

// @ VISUAL OPTIONS

GMFUNC(__imext_text_editor_get_tab_size)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_i64(Result, _editor->GetTabSize());
	GMRETURNS(Real)
}

GMFUNC(__imext_text_editor_set_tab_size)
{
	int64_t _size	= YYGetInt64(arg, 0);
	int32_t _handle = YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SetTabSize(_size);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_is_showing_whitespaces)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->IsShowingWhitespaces());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_set_show_whitespaces)
{
	int64_t _enable	= YYGetBool(arg, 0);
	int32_t _handle = YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SetShowWhitespaces(_enable);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_is_colorizer_enabled)
{
	int32_t _handle = YYGetInt32(arg, 0);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	__return_bool(Result, _editor->IsColorizerEnabled());
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_set_colorizer_enable)
{
	int64_t _enable	= YYGetBool(arg, 0);
	int32_t _handle = YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	_editor->SetColorizerEnable(_enable);
	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_set_palette)
{
	int64_t _paletteID	= YYGetInt64(arg, 0);
	int32_t _handle		= YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	switch (_paletteID)
	{
		case ImTextEditorPalette_Dark:		_editor->SetPalette(TextEditor::GetDarkPalette());		break;
		case ImTextEditorPalette_Light:		_editor->SetPalette(TextEditor::GetLightPalette());		break;
		case ImTextEditorPalette_RetroBlue:	_editor->SetPalette(TextEditor::GetRetroBluePalette());	break;
		case ImTextEditorPalette_GameMaker:	_editor->SetPalette(TextEditor::GetGameMakerPalette());	break;
		default:
			_editor->SetPalette(TextEditor::GetDarkPalette());	break;
	}

	__return_bool(Result, true);
	GMRETURNS(Bool)
}

GMFUNC(__imext_text_editor_get_palette_color)
{
	int64_t _index	= YYGetInt64(arg, 0);
	int32_t _handle = YYGetInt32(arg, 1);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	// Check if the index is valid
	if (_index < 0 || _index >= (int32_t)TextEditor::PaletteIndex::Max)
		__return_bool(Result, false);

	const auto& _pal = _editor->GetPalette();

	ImU32 c = _pal[_index];

	Result.kind = VALUE_REAL;
	Result.val	= IMU32_TO_GML_RGB(c);

	GMRETURNS(Bool|Real)
}

GMFUNC(__imext_text_editor_set_palette_color)
{
	int32_t _index	= YYGetInt32(arg, 0);
	int32_t _color	= YYGetInt32(arg, 1);
	int _alpha		= YYGetReal(arg, 2);	GMDEFAULT(255);
	int32_t _handle = YYGetInt32(arg, 3);
	GMHIDDEN();
	GMPASSTHROUGH(self.handle)

	CHECK_EDITOR_BOOL;

	// Check if the index is valid
	if (_index < 0 || _index >= (int32_t)TextEditor::PaletteIndex::Max)
		__return_bool(Result, false);

	TextEditor::Palette _pal = _editor->GetPalette();

	int R = _color & 0xFF;
	int G = (_color >> 8) & 0xFF;
	int B = (_color >> 16) & 0xFF;

	_pal[_index] = IM_COL32(R, G, B, _alpha);
	_editor->SetPalette(_pal);

	__return_bool(Result, true);
	GMRETURNS(Bool)
}