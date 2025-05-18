///
/// Step Event
///

/// Handle global shortcuts
if (global.use_imgui_input) {
    if ImGui.IsKeyDown(ImGuiKey.ImGuiMod_Ctrl) {
        if ImGui.IsKeyPressed(ImGuiKey.N) {
            if room_exists(room_next(room)) room_goto_next();
        } else if ImGui.IsKeyPressed(ImGuiKey.P) {
            if room_exists(room_previous(room)) room_goto_previous();
        } else if ImGui.IsKeyPressed(ImGuiKey.D) {
            stats_on = !stats_on;
            if stats_on {
                if stats_ui_kind == "IMGUI" reset_stats_graph();
            }
        }
    }
} else {
    if keyboard_check_direct(vk_control) {
        if keyboard_check_pressed(ord("N")) {
            if room_exists(room_next(room)) room_goto_next();
            keyboard_clear(vk_control);
            keyboard_clear(ord("N"));
        }
        if keyboard_check_pressed(ord("P")) {
            if room_exists(room_previous(room)) room_goto_previous();
            keyboard_clear(vk_control);
            keyboard_clear(ord("N"));
        }
        if keyboard_check_pressed(ord("D")) {
            stats_on = !stats_on;
            if stats_on {
                if stats_ui_kind == "IMGUI" reset_stats_graph();
            }
            keyboard_clear(vk_control);
            keyboard_clear(ord("D"));
        }
    }    
}


tick++;

/// Memory Usage
if (tick % game_get_speed(gamespeed_fps) == 0) {
    var memory_new = debug_event("DumpMemory", true).totalUsed;
    memory_difference = memory_new - memory;
    memory = memory_new;
}


/// Docking
if (global.enable_docking) ImGui.DockSpaceOverViewport();

/// Main Menu
var _exit_modal = false;

ImGui.BeginMainMenuBar();
if (ImGui.BeginMenu("Main")) {
    if (ImGui.MenuItem("Enable Viewport", undefined, global.enable_docking)) {
        global.enable_docking = !global.enable_docking;
    }
    ImGui.Separator();
    if (ImGui.MenuItem("Exit")) {
        _exit_modal = true;
    }
    ImGui.EndMenu();
}

if (ImGui.BeginMenu("Controls")) {
    ImGui.SeparatorText("Stats");
    ImGui.TextDisabled("Enabled: " + (stats_on ? "Yes" : "No"));
    ImGui.TextDisabled("Kind: " + string(stats_ui_kind));
    if (ImGui.MenuItem($"Enable Stats", "Ctrl + D", stats_on)) {
        stats_on = !stats_on;
        if (stats_on) { reset_stats_graph(); }
    }
    if (ImGui.MenuItem($"Switch kind")) {
        if stats_ui_kind == "GM" {
            stats_ui_kind = "IMGUI";
        } else if stats_ui_kind == "IMGUI" {
            stats_ui_kind = "GM";
        }
    }
    ImGui.NewLine();

    ImGui.SeparatorText("Rooms");
    var _prev_name = room_exists(room_previous(room)) ? room_get_name(room_previous(room)) : "";
    var _next_name = room_exists(room_next(room)) ? room_get_name(room_next(room)) : "";
    var _current_name = room_get_name(room);

    if (ImGui.MenuItem($"Previous", "Ctrl + P", undefined, _prev_name != "")) {
        if room_exists(room_previous(room)) room_goto_previous();
    }
    if (ImGui.MenuItem($"Next", "Ctrl + N", undefined, _next_name != "")) {
        if room_exists(room_next(room)) room_goto_next();
    }
    if (ImGui.BeginMenu("Go to room")) {
        struct_foreach(global.all_rooms, function(key, value) {
            var _is_current_room = room_get_name(room) == key;
            if (ImGui.MenuItem(key, undefined, _is_current_room, not _is_current_room)) { room_goto(value); }
        });
        ImGui.EndMenu();
    }
    ImGui.EndMenu();
}

if instance_exists(objExample) {
    with objExample {
        if (ImGui.BeginMenu("Current Room")) {
            if (ImGui.MenuItem("Show Example Window", undefined, main_open)) main_open = !main_open;
            if (ImGui.MenuItem("Show Demos", undefined, demo_open)) demo_open = !demo_open;    
            if (ImGui.MenuItem("Show Demo Window (ImGui)", undefined, demo_imgui)) demo_imgui = !demo_imgui;
            ImGui.EndMenu();
        }
    }
} else if instance_exists(objTests) {
    with objTests {
        if (ImGui.BeginMenu("Current Room")) {
            if (ImGui.MenuItem("Show Button Grid Test", undefined, button_grid_open)) button_grid_open = !button_grid_open;
            ImGui.EndMenu();
        }
    }
}
ImGui.EndMainMenuBar();

/// Modal
if (_exit_modal) ImGui.OpenPopup("Exit?");

ImGui.SetNextWindowPos(window_get_width() / 2, window_get_height () / 2, ImGuiCond.Appearing, 0.5, 0.5);
if (ImGui.BeginPopupModal("Exit?", undefined, ImGuiWindowFlags.NoResize)) {
    ImGui.Text("Are you sure you want to exit?");
    ImGui.Separator();
    if (ImGui.Button("Yes")) game_end();
    ImGui.SameLine();
    if (ImGui.Button("Nevermind")) ImGui.CloseCurrentPopup();
    ImGui.EndPopup();
}

/// Stats
if stats_on {
    if stats_ui_kind == "IMGUI" {
        if (tick % game_get_speed(gamespeed_fps) == 0) {
            update_stats_graph();
        }
        render_stats_imgui();
    }
}

render_status_bar();
