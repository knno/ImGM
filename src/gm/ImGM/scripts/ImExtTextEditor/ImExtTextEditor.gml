function ImExtTextEditor(_title, initialText="", languageID=0) constructor {

	#region Binds

	/**
	 * @function CanRedo
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static CanRedo = function() {
		return __imext_text_editor_can_redo(self.handle);
	}

	/**
	 * @function CanUndo
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static CanUndo = function() {
		return __imext_text_editor_can_undo(self.handle);
	}

	/**
	 * @function Cleanup
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Cleanup = function() {
		return __imext_text_editor_cleanup();
	}

	/**
	 * @function Copy
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Copy = function() {
		return __imext_text_editor_copy(self.handle);
	}

	/**
	 * @function Create
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Real}
	 */
	static Create = function() {
		return __imext_text_editor_create();
	}

	/**
	 * @function Cut
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Cut = function() {
		return __imext_text_editor_cut(self.handle);
	}

	/**
	 * @function Delete
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Delete = function() {
		return __imext_text_editor_delete(self.handle);
	}

	/**
	 * @function Destroy
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {undefined}
	 */
	static Destroy = function() {
		return __imext_text_editor_destroy(self.handle);
	}

	/**
	 * @function GetCursorPosColumn
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Real}
	 */
	static GetCursorPosColumn = function() {
		return __imext_text_editor_get_cursor_pos_column(self.handle);
	}

	/**
	 * @function GetCursorPosLine
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Real}
	 */
	static GetCursorPosLine = function() {
		return __imext_text_editor_get_cursor_pos_line(self.handle);
	}

	/**
	 * @function GetPaletteColor
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _index
	 * @return {Bool|Real}
	 */
	static GetPaletteColor = function(_index) {
		return __imext_text_editor_get_palette_color(_index, self.handle);
	}

	/**
	 * @function GetSelectedText
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {String}
	 */
	static GetSelectedText = function() {
		return __imext_text_editor_get_selected_text(self.handle);
	}

	/**
	 * @function GetTabSize
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Real}
	 */
	static GetTabSize = function() {
		return __imext_text_editor_get_tab_size(self.handle);
	}

	/**
	 * @function GetText
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {String}
	 */
	static GetText = function() {
		return __imext_text_editor_get_text(self.handle);
	}

	/**
	 * @function GetTotalLines
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Real}
	 */
	static GetTotalLines = function() {
		return __imext_text_editor_get_total_lines(self.handle);
	}

	/**
	 * @function HasSelection
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static HasSelection = function() {
		return __imext_text_editor_has_selection(self.handle);
	}

	/**
	 * @function InsertText
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _handle
	 * @param {String} _text
	 * @return {Bool}
	 */
	static InsertText = function(_handle, _text) {
		return __imext_text_editor_insert_text(_handle, _text);
	}

	/**
	 * @function IsColorizerEnabled
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static IsColorizerEnabled = function() {
		return __imext_text_editor_is_colorizer_enabled(self.handle);
	}

	/**
	 * @function IsOverwrite
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static IsOverwrite = function() {
		return __imext_text_editor_is_overwrite(self.handle);
	}

	/**
	 * @function IsReadOnly
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static IsReadOnly = function() {
		return __imext_text_editor_is_read_only(self.handle);
	}

	/**
	 * @function IsShowingWhitespaces
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static IsShowingWhitespaces = function() {
		return __imext_text_editor_is_showing_whitespaces(self.handle);
	}

	/**
	 * @function IsTextModified
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static IsTextModified = function() {
		return __imext_text_editor_is_text_modified(self.handle);
	}

	/**
	 * @function Paste
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Paste = function() {
		return __imext_text_editor_paste(self.handle);
	}

	/**
	 * @function Redo
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Redo = function() {
		return __imext_text_editor_redo(self.handle);
	}

	/**
	 * @function Render
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} [_width=0]
	 * @param {Real} [_height=0]
	 * @param {Real} [_flags=0]
	 * @return {Bool}
	 */
	static Render = function(_width=0, _height=0, _flags=0) {
		return __imext_text_editor_render(_width, _height, _flags, self.handle, self.title);
	}

	/**
	 * @function SelectAll
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static SelectAll = function() {
		return __imext_text_editor_select_all(self.handle);
	}

	/**
	 * @function SelectLine
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _line
	 * @return {Bool}
	 */
	static SelectLine = function(_line) {
		return __imext_text_editor_select_line(_line, self.handle);
	}

	/**
	 * @function SelectWordUnderCursor
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static SelectWordUnderCursor = function() {
		return __imext_text_editor_select_word_under_cursor(self.handle);
	}

	/**
	 * @function SetColorizerEnable
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Bool} _enable
	 * @return {Bool}
	 */
	static SetColorizerEnable = function(_enable) {
		return __imext_text_editor_set_colorizer_enable(_enable, self.handle);
	}

	/**
	 * @function SetCursorPosLineColumn
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} [_line=1]
	 * @param {Real} [_column=1]
	 * @return {Bool}
	 */
	static SetCursorPosLineColumn = function(_line=1, _column=1) {
		return __imext_text_editor_set_cursor_pos_line_column(_line, _column, self.handle);
	}

	/**
	 * @function SetLanguage
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} [_languageID=0]
	 * @return {Bool}
	 */
	static SetLanguage = function(_languageID=0) {
		return __imext_text_editor_set_language(_languageID, self.handle);
	}

	/**
	 * @function SetPalette
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _paletteID
	 * @return {Bool}
	 */
	static SetPalette = function(_paletteID) {
		return __imext_text_editor_set_palette(_paletteID, self.handle);
	}

	/**
	 * @function SetPaletteColor
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _index
	 * @param {Real} _color
	 * @param {Real} [_alpha=255]
	 * @return {Bool}
	 */
	static SetPaletteColor = function(_index, _color, _alpha=255) {
		return __imext_text_editor_set_palette_color(_index, _color, _alpha, self.handle);
	}

	/**
	 * @function SetReadOnly
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Bool} _readOnly
	 * @return {Bool}
	 */
	static SetReadOnly = function(_readOnly) {
		return __imext_text_editor_set_read_only(_readOnly, self.handle);
	}

	/**
	 * @function SetShowWhitespaces
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Bool} _enable
	 * @return {Bool}
	 */
	static SetShowWhitespaces = function(_enable) {
		return __imext_text_editor_set_show_whitespaces(_enable, self.handle);
	}

	/**
	 * @function SetTabSize
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {Real} _size
	 * @return {Bool}
	 */
	static SetTabSize = function(_size) {
		return __imext_text_editor_set_tab_size(_size, self.handle);
	}

	/**
	 * @function SetText
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @param {String} _text
	 * @return {undefined}
	 */
	static SetText = function(_text) {
		return __imext_text_editor_set_text(_text, self.handle);
	}

	/**
	 * @function Undo
	 * @context TextEditor
	 * @desc ImGM custom wrapper for `TextEditor`.
	 *
	 * @return {Bool}
	 */
	static Undo = function() {
		return __imext_text_editor_undo(self.handle);
	}

	#endregion

    #region Enums

    #endregion

    #region Internal

	handle = __imext_text_editor_create();
	title = _title;

	SetText(initialText)
	SetLanguage(languageID);

    /// autocalls
    __ImGui_Shutdown = method(self, function(state) {
		return __imext_text_editor_cleanup();
    })

	#endregion
}
