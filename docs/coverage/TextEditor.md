# TextEditor Coverage

**Coverage:** 56% (32/57)


## Wrappers

These are the wrappers of functions generated for TextEditor.

| Wrapper | Covered | Wrapper Location | Note |
|---------|---------|------------------|------|
| `TextEditor.SetLanguageDefinition` | ✅ | - | Use `editor.SetLanguage` |
| `TextEditor.GetLanguageDefinition` | ❌ | - | - |
| `TextEditor.GetPalette` | ✅ | - | Use `editor.GetPaletteColor` |
| `TextEditor.SetPalette` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L517) | - |
| `TextEditor.SetErrorMarkers` | ❌ | - | - |
| `TextEditor.SetBreakpoints` | ❌ | - | - |
| `TextEditor.Render` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L114) | - |
| `TextEditor.SetText` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L66) | - |
| `TextEditor.GetText` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L78) | - |
| `TextEditor.SetTextLines` | ❌ | - | - |
| `TextEditor.GetTextLines` | ❌ | - | - |
| `TextEditor.GetSelectedText` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L236) | - |
| `TextEditor.GetCurrentLineText` | ❌ | - | - |
| `TextEditor.GetTotalLines` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L295) | - |
| `TextEditor.IsOverwrite` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L361) | - |
| `TextEditor.SetReadOnly` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L146) | - |
| `TextEditor.IsReadOnly` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L134) | - |
| `TextEditor.IsTextChanged` | ❌ | - | - |
| `TextEditor.IsCursorPositionChanged` | ❌ | - | - |
| `TextEditor.IsColorizerEnabled` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L491) | - |
| `TextEditor.SetColorizerEnable` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L503) | - |
| `TextEditor.GetCursorPosition` | ✅ | - | Supported with suffix (Line, Column) |
| `TextEditor.SetCursorPosition` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L248) | - |
| `TextEditor.SetHandleMouseInputs` | ❌ | - | - |
| `TextEditor.IsHandleMouseInputsEnabled` | ❌ | - | - |
| `TextEditor.SetHandleKeyboardInputs` | ❌ | - | - |
| `TextEditor.IsHandleKeyboardInputsEnabled` | ❌ | - | - |
| `TextEditor.SetImGuiChildIgnored` | ❌ | - | - |
| `TextEditor.IsImGuiChildIgnored` | ❌ | - | - |
| `TextEditor.SetShowWhitespaces` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L477) | - |
| `TextEditor.IsShowingWhitespaces` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L465) | - |
| `TextEditor.SetTabSize` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L451) | - |
| `TextEditor.GetTabSize` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L439) | - |
| `TextEditor.InsertText` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L425) | - |
| `TextEditor.MoveUp` | ❌ | - | - |
| `TextEditor.MoveDown` | ❌ | - | - |
| `TextEditor.MoveLeft` | ❌ | - | - |
| `TextEditor.MoveRight` | ❌ | - | - |
| `TextEditor.MoveTop` | ❌ | - | - |
| `TextEditor.MoveBottom` | ❌ | - | - |
| `TextEditor.MoveHome` | ❌ | - | - |
| `TextEditor.MoveEnd` | ❌ | - | - |
| `TextEditor.SetSelectionStart` | ❌ | - | - |
| `TextEditor.SetSelectionEnd` | ❌ | - | - |
| `TextEditor.SetSelection` | ✅ | - | Use `editor.SelectLine` |
| `TextEditor.SelectWordUnderCursor` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L200) | - |
| `TextEditor.SelectAll` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L187) | - |
| `TextEditor.HasSelection` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L175) | - |
| `TextEditor.Copy` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L373) | - |
| `TextEditor.Cut` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L399) | - |
| `TextEditor.Paste` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L386) | - |
| `TextEditor.Delete` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L412) | - |
| `TextEditor.CanUndo` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L309) | - |
| `TextEditor.CanRedo` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L321) | - |
| `TextEditor.Undo` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L333) | - |
| `TextEditor.Redo` | ✅ | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L346) | - |


## Custom Wrappers

These are non-standard functions made specifically for TextEditor.

| Wrapper | Wrapper Location | Note |
|---------|------------------|------|
| `TextEditor.Cleanup` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L48) | - |
| `TextEditor.Create` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L9) | - |
| `TextEditor.Destroy` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L30) | - |
| `TextEditor.GetCursorPosColumn` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L280) | - |
| `TextEditor.GetCursorPosLine` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L265) | - |
| `TextEditor.GetPaletteColor` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L540) | - |
| `TextEditor.IsTextModified` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L161) | - |
| `TextEditor.SelectLine` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L213) | - |
| `TextEditor.SetLanguage` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L90) | - |
| `TextEditor.SetPaletteColor` | [text_editor_wrappers_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imext/text_editor/wrappers/text_editor_wrappers_gm.cpp#L563) | - |