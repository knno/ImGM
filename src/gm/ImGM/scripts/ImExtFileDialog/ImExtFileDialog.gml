function ImExtFileDialog() constructor {
    #region Binds

    /**
	 * @function AddFavorite
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Adds a favorite folder shortcut to the side pane.
	 *
	 * @param {String} path
	 * @return {Undefined}
	 */
	static AddFavorite = function(path) {
		return __imext_file_dialog_add_favorite(path);
	}

	/**
	 * @function Close
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Closes the current dialog.
	 *
	 * @return {Undefined}
	 */
	static Close = function() {
		return __imext_file_dialog_close();
	}

	/**
	 * @function GetFavorite
	 * @context FileDialog
	 * @desc ImGM custom wrapper for `FileDialog`.
	 * Returns a favorite folder path by index.
	 *
	 * @param {Real} index The favorite index.
	 * @return {String}
	 */
	static GetFavorite = function(index) {
		return __imext_file_dialog_get_favorite(index);
	}

	/**
	 * @function GetFavoritesCount
	 * @context FileDialog
	 * @desc ImGM custom wrapper for `FileDialog`.
	 * Returns the number of favorite folders.
	 *
	 * @return {Real}
	 */
	static GetFavoritesCount = function() {
		return __imext_file_dialog_get_favorites_count();
	}

	/**
	 * @function GetResult
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns the file path result as a string.
	 *
	 * @return {String}
	 */
	static GetResult = function() {
		return __imext_file_dialog_get_result();
	}

	/**
	 * @function GetResultCount
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns the number of files selected (if multiselect is enabled).
	 *
	 * @return {Real}
	 */
	static GetResultCount = function() {
		return __imext_file_dialog_get_result_count();
	}

	/**
	 * @function GetResultIndex
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns the file path result at the given index (for multiselect).
	 *
	 * @param {Real} index
	 * @return {String}
	 */
	static GetResultIndex = function(index) {
		return __imext_file_dialog_get_result_index(index);
	}

	/**
	 * @function GetZoom
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns the current zoom factor.
	 *
	 * @return {Real}
	 */
	static GetZoom = function() {
		return __imext_file_dialog_get_zoom();
	}

	/**
	 * @function HasResult
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns whether the dialog finished with a successful result.
	 *
	 * @return {Bool}
	 */
	static HasResult = function() {
		return __imext_file_dialog_has_result();
	}

	/**
	 * @function IsDone
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Returns whether the dialog has finished (user confirmed or canceled).
	 *
	 * @param {String} key
	 * @return {Bool}
	 */
	static IsDone = function(key) {
		return __imext_file_dialog_is_done(key);
	}

	/**
	 * @function Open
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Opens a file dialog.
	 *
	 * @param {String} key
	 * @param {String} title
	 * @param {String} filter
	 * @param {Bool} is_multiselect
	 * @param {String} starting_dir
	 * @return {Undefined}
	 */
	static Open = function(key, title, filter, is_multiselect, starting_dir) {
		return __imext_file_dialog_open(key, title, filter, is_multiselect, starting_dir);
	}

	/**
	 * @function RemoveFavorite
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Removes a favorite folder shortcut.
	 *
	 * @param {String} path
	 * @return {Undefined}
	 */
	static RemoveFavorite = function(path) {
		return __imext_file_dialog_remove_favorite(path);
	}

	/**
	 * @function Save
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Opens a save file dialog.
	 *
	 * @param {String} key
	 * @param {String} title
	 * @param {String} filter
	 * @param {String} starting_dir
	 * @param {String} starting_file
	 * @return {Undefined}
	 */
	static Save = function(key, title, filter, starting_dir, starting_file) {
		return __imext_file_dialog_save(key, title, filter, starting_dir, starting_file);
	}

	/**
	 * @function Setup
	 * @context FileDialog
	 * @desc ImGM custom wrapper for `FileDialog`.
	 * Initializes ImFileDialog and textures for rendering.
	 *
	 * @param {Bool} [is_gm_mode=undefined]
	 * @param {Real} [icon_folder_sprite=undefined]
	 * @param {Real} [icon_folder_sprite_image_index=0]
	 * @param {Real} [icon_file_sprite=undefined]
	 * @param {Real} [icon_file_sprite_image_index=0]
	 * @param {Real} [icon_quick_access_sprite=undefined]
	 * @param {Real} [icon_quick_access_sprite_image_index=0]
	 * @return {Undefined}
	 */
	static Setup = function(is_gm_mode=undefined, icon_folder_sprite=undefined, icon_folder_sprite_image_index=0, icon_file_sprite=undefined, icon_file_sprite_image_index=0, icon_quick_access_sprite=undefined, icon_quick_access_sprite_image_index=0) {
		return __imext_file_dialog_setup(is_gm_mode, icon_folder_sprite, icon_folder_sprite_image_index, icon_file_sprite, icon_file_sprite_image_index, icon_quick_access_sprite, icon_quick_access_sprite_image_index);
	}

	/**
	 * @function SetZoom
	 * @context FileDialog
	 * @desc ImGM wrapper for `FileDialog`.
	 * Sets the zoom factor for the file dialog icons/thumbnails.
	 *
	 * @param {Real} zoom
	 * @return {Undefined}
	 */
	static SetZoom = function(zoom) {
		return __imext_file_dialog_set_zoom(zoom);
	}

    #endregion

	#region Enums

	#endregion

    #region Internal

	/**
	 * @function GetFavorites
	 * @context FileDialog
	 * @desc ImGM custom wrapper for `FileDialog`.
	 *
	 * @param {Array<String>} [out_array=undefined] Array for storing the result
	 * @return {Array<String>}
	 */
	static GetFavorites = function(out_array=undefined) {
		var _c = __imext_file_dialog_get_favorites_count();
		out_array ??= [];
		array_resize(out_array, _c);
		for (var _i = 0; _i < _c; _i++) {
			out_array[_i] = __imext_file_dialog_get_favorite(_i);
		}
        return out_array;
	}

	static __initialized = false;

    static Initialize = function() {
		var _is_gm_render = ((IMGM_GFLAGS & ImGuiGFlags.GM) != 0);
		ImExtFileDialog.Setup(_is_gm_render, spr_imgm_imext_file_dialog_icon_folder,0, spr_imgm_imext_file_dialog_icon_file,0, spr_imgm_imext_file_dialog_icon_folder,0);
        ImExtFileDialog.__initialized = true;
    }
	
    /// autocalls
	static __ImGui_Initialize = method(self, function() {
		return Initialize();
	})

	#endregion
}
