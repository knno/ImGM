if button_grid_open {
    if !button_grid_loaded {
        if !GM_is_sandboxed {
            button_sprites = load_sprites(filename_dir(GM_project_filename) + "/../../../tests/sprites", "*.png");
        } else {
            button_sprites = load_sprites(game_save_id + "\\tests\\sprites", "*.png");
        }
        button_grid_loaded = true;
    }
    if button_grid_loaded show_image_button_grid();
}