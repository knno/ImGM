/// @description Testing only!

load_sprites = function(_folder_path, _pattern="*.png") {
    var _sprite_struct = {};

    if (directory_exists(_folder_path)) {
        var _file_list = file_find_first(_folder_path + "/" + _pattern, fa_none);

        while (_file_list != "") {
            var _file_name = _file_list;
            var _base_name = filename_name(_file_name);

            // Load the sprite from the file
            var _sprite = sprite_add(_folder_path + "/" + _file_name, 1, false, false, 0, 0);

            if (_sprite != -1) {
                _sprite_struct[$ _base_name] = _sprite;
            } else {
                show_debug_message("load_sprites: Failed to load sprite: " + _file_name);
            }

            // Proceed to the next file
            _file_list = file_find_next();
        }

        // Clean up after file_find
        file_find_close();
    } else {
        show_debug_message("load_sprites: Folder does not exist: " + _folder_path);
    }

    var _count = struct_names_count(_sprite_struct);
    show_debug_message($"load_sprites: loaded {_count} sprites");
    return _sprite_struct; // Return the struct containing the loaded sprites
}

button_sprites = {};
if GM_is_sandboxed {
    show_debug_message("Tests detected sandboxed project");
}

show_image_button_grid = function() {
    ImGui.SetNextWindowSize(room_width/2, room_height/2, ImGuiCond.Appearing);
    ImGui.SetNextWindowPos(room_width/4, room_height/4, ImGuiCond.Appearing);
    ImGui.SetNextWindowSizeConstraints(room_width/3, room_height/3, room_width/1.5, room_height/1.5);
    var _item_spacing = 5;
    ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, _item_spacing, _item_spacing);
    ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 1, 1);

    if (ImGui.Begin("Button Sprites Grid")) {
        var _window_width = ImGui.GetWindowWidth();
        var _window_padding = 5;
        var _available_width = _window_width - (2 * _window_padding);
        var _names = struct_get_names(button_sprites);
        var _sprite_count = struct_names_count(button_sprites);
        var _button_size = 18;
        var _grid_cols = floor((_available_width + _item_spacing) / (_button_size + _item_spacing)) - 2;
        if (_grid_cols <= 0) { _grid_cols = 1; }
        var _grid_rows = ceil(_sprite_count / _grid_cols);
        var _counter = 0;
        var _hovered_spr_name = -1;

        // Loop through the grid rows and columns
        for (var _row = 0; _row < _grid_rows; _row++) {
            for (var _col = 0; _col < _grid_cols; _col++) {
                if (_counter < _sprite_count) {
                    var _sprite_name = _names[_counter];

                    // Create the ImageButton
                    if (ImGui.ImageButton($"-#test-btn-{_sprite_name}", button_sprites[$ _sprite_name], 0, c_white, 1, c_aqua, c_dkgray, _button_size, _button_size)) {
                        show_message("Button - " + _sprite_name + " - clicked!");
                    }

                    // Check if the button is hovered
                    if (_hovered_spr_name == -1 && ImGui.IsItemHovered()) {
                        _hovered_spr_name = _sprite_name;
                    }
                }

                _counter++;

                // Add spacing between columns and wrap rows properly
                if (_counter mod _grid_cols != 0) {
                    ImGui.SameLine();
                }
            }
        }

        ImGui.End();
        ImGui.PopStyleVar();
        ImGui.PopStyleVar();
        if (_hovered_spr_name != -1) {
            var _spr = button_sprites[$ _hovered_spr_name]
            var _mouse_pos_x = ImGui.GetMousePosX();
            var _mouse_pos_y = ImGui.GetMousePosY();
            ImGui.BeginTooltip()
            ImGui.Image(_spr, 0, c_white, 1, sprite_get_width(_spr), sprite_get_height(_spr));
            ImGui.EndTooltip();
        }
    }
}

button_grid_loaded = false;
button_grid_open = false;
