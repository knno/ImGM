/// @description Remove Loaded data

struct_foreach(button_sprites, function(key, value) {
    sprite_delete(button_sprites[$ key]);
});

show_debug_message("Tests data cleaned up");
