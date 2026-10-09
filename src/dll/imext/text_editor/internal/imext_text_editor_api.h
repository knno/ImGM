// A header file used by the tools wrappers:gen

#pragma once
#include "imgui_text_editor.h"

#ifndef IMEXT_TEXT_EDITOR_API
#define IMEXT_TEXT_EDITOR_API
#endif

namespace TextEditor {

    IMEXT_TEXT_EDITOR_API void SetLanguageDefinition(const LanguageDefinition& aLanguageDef);
    IMEXT_TEXT_EDITOR_API const LanguageDefinition& GetLanguageDefinition() const { return mLanguageDefinition; }

    IMEXT_TEXT_EDITOR_API const Palette& GetPalette() const { return mPaletteBase; }
    IMEXT_TEXT_EDITOR_API void SetPalette(const Palette& aValue);

    IMEXT_TEXT_EDITOR_API void SetErrorMarkers(const ErrorMarkers& aMarkers) { mErrorMarkers = aMarkers; }
    IMEXT_TEXT_EDITOR_API void SetBreakpoints(const Breakpoints& aMarkers) { mBreakpoints = aMarkers; }

    IMEXT_TEXT_EDITOR_API void Render(const char* aTitle, const ImVec2& aSize = ImVec2(), bool aBorder = false);
    IMEXT_TEXT_EDITOR_API void SetText(const std::string& aText);
    IMEXT_TEXT_EDITOR_API std::string GetText();

    IMEXT_TEXT_EDITOR_API void SetTextLines(const std::vector<std::string>& aLines);
    IMEXT_TEXT_EDITOR_API std::vector<std::string> GetTextLines()

    IMEXT_TEXT_EDITOR_API std::string GetSelectedText()
    IMEXT_TEXT_EDITOR_API std::string GetCurrentLineText()const;

    IMEXT_TEXT_EDITOR_API int GetTotalLines() const { return (int)mLines.size(); }
    IMEXT_TEXT_EDITOR_API bool IsOverwrite() const { return mOverwrite; }

    IMEXT_TEXT_EDITOR_API void SetReadOnly(bool aValue);
    IMEXT_TEXT_EDITOR_API bool IsReadOnly() const { return mReadOnly; }
    IMEXT_TEXT_EDITOR_API bool IsTextChanged() const { return mTextChanged; }
    IMEXT_TEXT_EDITOR_API bool IsCursorPositionChanged() const { return mCursorPositionChanged; }

    IMEXT_TEXT_EDITOR_API bool IsColorizerEnabled() const { return mColorizerEnabled; }
    IMEXT_TEXT_EDITOR_API void SetColorizerEnable(bool aValue);

    IMEXT_TEXT_EDITOR_API Coordinates GetCursorPosition() const { return GetActualCursorCoordinates(); }
    IMEXT_TEXT_EDITOR_API void SetCursorPosition(const Coordinates& aPosition);

    IMEXT_TEXT_EDITOR_API inline void SetHandleMouseInputs(bool aValue) { mHandleMouseInputs = aValue; }
    IMEXT_TEXT_EDITOR_API inline bool IsHandleMouseInputsEnabled() const { return mHandleKeyboardInputs; }

    IMEXT_TEXT_EDITOR_API inline void SetHandleKeyboardInputs(bool aValue) { mHandleKeyboardInputs = aValue; }
    IMEXT_TEXT_EDITOR_API inline bool IsHandleKeyboardInputsEnabled() const { return mHandleKeyboardInputs; }

    IMEXT_TEXT_EDITOR_API inline void SetImGuiChildIgnored(bool aValue) { mIgnoreImGuiChild = aValue; }
    IMEXT_TEXT_EDITOR_API inline bool IsImGuiChildIgnored() const { return mIgnoreImGuiChild; }

    IMEXT_TEXT_EDITOR_API inline void SetShowWhitespaces(bool aValue) { mShowWhitespaces = aValue; }
    IMEXT_TEXT_EDITOR_API inline bool IsShowingWhitespaces() const { return mShowWhitespaces; }

    IMEXT_TEXT_EDITOR_API void SetTabSize(int aValue);
    IMEXT_TEXT_EDITOR_API inline int GetTabSize() const { return mTabSize; }

    IMEXT_TEXT_EDITOR_API void InsertText(const std::string& aValue);
    IMEXT_TEXT_EDITOR_API void InsertText(const char* aValue);

    IMEXT_TEXT_EDITOR_API void MoveUp(int aAmount = 1, bool aSelect = false);
    IMEXT_TEXT_EDITOR_API void MoveDown(int aAmount = 1, bool aSelect = false);
    IMEXT_TEXT_EDITOR_API void MoveLeft(int aAmount = 1, bool aSelect = false, bool aWordMode = false);
    IMEXT_TEXT_EDITOR_API void MoveRight(int aAmount = 1, bool aSelect = false, bool aWordMode = false);
    IMEXT_TEXT_EDITOR_API void MoveTop(bool aSelect = false);
    IMEXT_TEXT_EDITOR_API void MoveBottom(bool aSelect = false);
    IMEXT_TEXT_EDITOR_API void MoveHome(bool aSelect = false);
    IMEXT_TEXT_EDITOR_API void MoveEnd(bool aSelect = false);

    IMEXT_TEXT_EDITOR_API void SetSelectionStart(const Coordinates& aPosition);
    IMEXT_TEXT_EDITOR_API void SetSelectionEnd(const Coordinates& aPosition);
    IMEXT_TEXT_EDITOR_API void SetSelection(const Coordinates& aStart, const Coordinates& aEnd, SelectionMode aMode = SelectionMode::Normal);
    IMEXT_TEXT_EDITOR_API void SelectWordUnderCursor();
    IMEXT_TEXT_EDITOR_API void SelectAll();
    IMEXT_TEXT_EDITOR_API bool HasSelection()

    IMEXT_TEXT_EDITOR_API void Copy();
    IMEXT_TEXT_EDITOR_API void Cut();
    IMEXT_TEXT_EDITOR_API void Paste();
    IMEXT_TEXT_EDITOR_API void Delete();

    IMEXT_TEXT_EDITOR_API bool CanUndo()
    IMEXT_TEXT_EDITOR_API bool CanRedo()
    IMEXT_TEXT_EDITOR_API void Undo(int aSteps = 1);
    IMEXT_TEXT_EDITOR_API void Redo(int aSteps = 1);
}