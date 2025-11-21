/*

This is the controller GameMaker object which does the following:

 - It calls ImGui events, such as __BeginFrame, __EndFrame, and __Render.
 - It handles updates to the GameMaker window and synchronizing it with the backend (ImGui)

*/
///
/// @description Create event
///


// Test framework

#region Initialize ImGui

imgm = __ImGM();

/// Optional: Define common config flags
var _imgui_config_flags = ImGuiConfigFlags.DockingEnable | ImGuiConfigFlags.ViewportsEnable;

ImGui.__Initialize(_imgui_config_flags);

imgui_state = ImGui.__state; // Capture the created state.
imgui_window = ImGui.__window; // Capture the created gamewindow.

/// Optional: Ini settings
ini_filename = "";
// ini_filename = game_save_id + "imgm.ini";

if ini_filename != "" {
    ImGui.IniFilename(ini_filename);
    ImGui.LoadIniSettingsFromDisk(ini_filename);
}

#region Examples (Commented)

/// Optional: Create a new state example
/*
    imgui_state2 = new ImGuiState(); // Creates a Context
    imgui_window2 = new ImGuiBaseMainWindow(window_handle()); // Creates a "Window"
    /// imgui_state2.some_attribute = some_value;
    imgui_state2.Initialize(imgui_window2, _configs); // This does 3 things: init and use new state, set it to window, set config flags
    ImGui.AddFontDefault(); // Add default font to the context!
    imgui_state.Use(); // Return back to main state.
*/

#endregion Examples (Commented)

#endregion Initialize ImGui

// Setup input system to use
global.use_imgui_input = not (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM); // use imgui if renderer is not GM

// Accent color
global.accent_color = #00A1ff;

/// ImGui specific
global.font_default = ImGui.AddFontDefault();
global.font_roboto = ImGui.AddFontFromFileTTF("fonts/Roboto-Regular.ttf", 24);
global.enable_docking = false;

/// Example: Creating ImGui window classes
// global.window_class_basic = new ImGuiWindowClass(1, -1);
// global.window_class_no_automerge = new ImGuiWindowClass(2, -1, ImGuiViewportFlags.NoAutoMerge);

/// Rooms
var _all_room_ids = asset_get_ids(asset_room); // array of refs
global.all_rooms = {};
for (var _i=0; _i<array_length(_all_room_ids); _i++) {
    struct_set(global.all_rooms, room_get_name(_all_room_ids[_i]), asset_get_index(room_get_name(_all_room_ids[_i]))); // {name: id}
}

/// Other
memory = debug_event("DumpMemory", true).totalUsed;
operating_system = environment_get_variable("OS");
memory_difference = 0;
tick = 0;

/// Function to draw a status bar
render_status_bar = function() {
    var _status_height = 30;
    var _window_width = window_get_width();
    var _window_height = window_get_height();

    var _y = imgm.base_y + (_window_height - _status_height);
    var _x_offset = imgm.base_x;

    ImGui.SetNextWindowPos(_x_offset, _y, ImGuiCond.Always);
    ImGui.SetNextWindowSize(_window_width, _status_height, ImGuiCond.Always);
    if (ImGui.Begin("Status Bar", false, ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoScrollbar)) {
        ImGui.Text("Room:");
        ImGui.SameLine();
        var _pre = "   ";
        var _post = "   ";
        var _prev_name = room_exists(room_previous(room)) ? room_get_name(room_previous(room)) : "";
        var _next_name = room_exists(room_next(room)) ? room_get_name(room_next(room)) : "";
        var _current_name = room_get_name(room);

        if _prev_name != "" {
            if (room_exists(room_previous(room_previous(room)))) {
                _pre = "...";
            } else {
                _pre = "";
            }
            ImGui.TextDisabled(_pre + _prev_name);
            ImGui.SameLine();
            if _next_name == "" {
                ImGui.TextDisabled("<")
            } else {
                ImGui.TextDisabled(">")
            }
        } else {
            ImGui.TextColored("<begin>", c_green);
            ImGui.SameLine();
            ImGui.TextDisabled(">")
        }
        ImGui.SameLine();
        ImGui.TextColored(_current_name, global.accent_color, 1);
        ImGui.SameLine();
        if _next_name != "" {
            ImGui.SameLine();
            ImGui.TextDisabled(">")
            ImGui.SameLine();
            if (room_exists(room_next(room_next(room)))) {
                _post = "...";
            }
            ImGui.TextDisabled(_next_name + _post);
            ImGui.SameLine();
        } else {
            ImGui.TextDisabled(">")
            ImGui.SameLine();
            ImGui.TextColored("<end>", c_green);
        }

        if _window_width > 800 {
            ImGui.SameLine(_window_width/2);
            ImGui.TextDisabled("<placeholder>"); // Example status
        }
        if _window_width > 600 {
            ImGui.SameLine(_window_width - 150); // This align text to the far-right
            ImGui.Text($"ImGM v{IMGM_VERSION}");
        }

        ImGui.End();
    }
}

#region Stats

stats_on = true;
stats_ui_kind = "GM"; // or "IMGUI"
stats_graph = true; // header open
stats_graph_size = 10; // Graph data sizes
stats_graph_mem_step = 100; // MB
stats_graph_fps_step = 300; // Frames
stats_graph_mem_max = 1; // Number of steps for graph height
stats_graph_fps_max = 10;

stats_graph_fps_data = [];
stats_graph_mem_data = [];

/// Function to draw texts in the room.
draw_stats_gm = function() {
    draw_set_font(fnt_consolas);
    draw_set_color(c_white);
    var chr_width = string_width("_")
    var chr_height = string_height("|");
    var mem = memory / 1_000_000;
    var mem_diff = (sign(memory_difference) ? "+" : "") + string(memory_difference / 1000);

    var str_fps = string("{0} ({1})", fps, fps_real);
    var str_mem = string("{0} MB", mem);

    draw_text(5, 100,
        string("{0}\n{1}\n{2}\n{3}\n{4}\n{5}\n\n",
            "FPS:",
            "RAM:",
            "DLL Version:",
            "ImGui Version:",
            "GM Version:",
            "OS:",
            // "GM LMB:",
        )
    );
    draw_text(145, 100,
        string("{0}\n{1}\n{2}\n{3}\n{4}\n{5}\n\n",
            str_fps,
            str_mem,
            IMGM_VERSION,
            ImGui.GetVersion(),
            GM_version + " - " + GM_runtime_version,
            operating_system,
            // (mouse_check_button(mb_left) ? "(true)" : "(false)") + " - ImGui LMB:  " + (ImGui.IsMouseDown(ImGuiMouseButton.Left) ? "(true)" : "(false)"),
        )
    );

    if memory_difference > 200_000 draw_set_color(#ff5040);
    var pos_x = string_width(str_mem);
    var pos_y = chr_height;
    draw_text(145 + pos_x, 100 + pos_y,
        string(" ({0} KB)",
            mem_diff
        )
    );
    draw_set_color(c_white);
}

/// Function to draw texts in a custom ImGui window.
render_stats_imgui = function() {
    var _mem = memory / 1000000;
    var _mem_diff = (sign(memory_difference) ? "+" : "") + string(memory_difference / 1000);

    var _str_fps = string("{0}", fps);
    var _str_mem = string("{0} MB", _mem);

    ImGui.SetNextWindowSize(500, 300, ImGuiCond.Once);
    ImGui.SetNextWindowPos(10, 10, ImGuiCond.Once);

    var ret = ImGui.Begin("Info", stats_on, ImGuiWindowFlags.NoCollapse, ImGuiReturnMask.Both)
    if (ret & ImGuiReturnMask.Pointer) {
        if ImGui.CollapsingHeader("Stats", undefined, ImGuiTreeNodeFlags.DefaultOpen) {
            ImGui.TextDisabled("Current build information and running stats.");
            if (ImGui.BeginTable("Info", 2, ImGuiTableFlags.Borders)) {
                ImGui.TableSetupColumn("Label", ImGuiTableColumnFlags.None, 0.5);
                ImGui.TableSetupColumn("Value", ImGuiTableColumnFlags.None, 0.5);
                ImGui.TableHeadersRow();
                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("FPS:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(_str_fps);
                ImGui.SameLine()
                ImGui.TextColored($"({fps_real})", c_gray);

                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("RAM:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(_str_mem);
                ImGui.SameLine()
                ImGui.TextColored($"({_mem_diff} KB)", memory_difference > 200_000 ? #ff5040 : c_gray);

                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("DLL Version:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(IMGM_VERSION);
                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("ImGui Version:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(ImGui.GetVersion());
                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("GameMaker Version:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(GM_version + " - " + GM_runtime_version);
                ImGui.TableNextRow();
                ImGui.TableSetColumnIndex(0);
                ImGui.Text("OS:");
                ImGui.TableSetColumnIndex(1);
                ImGui.Text(operating_system);
                ImGui.EndTable();
            }
        }
        ImGui.NewLine();

        if ImGui.CollapsingHeader("Graphs") {
            ImGui.TextDisabled("Some graphs for metrics.");

            ImGui.NewLine();
            ImGui.SameLine(50);
            plot_lines_with_grid("##FPS", stats_graph_fps_data, 0, "FPS / Time", 0, stats_graph_fps_max * stats_graph_fps_step, ImGui.GetWindowWidth()-50-50, 100, stats_graph_size, 6);
            ImGui.NewLine();

            ImGui.NewLine();
            ImGui.SameLine(50);
            plot_lines_with_grid("##Memory", stats_graph_mem_data, 0, "Memory (MB) / Time", 0, stats_graph_mem_max * stats_graph_mem_step, ImGui.GetWindowWidth()-50-50, 100, stats_graph_size, 4);
            ImGui.NewLine();
        }

        ImGui.End();
    } else {
        stats_on = false;
    }
}

/// Function to init/reset graphs data arrays.
reset_stats_graph = function() {
    for (var _i=0; _i<stats_graph_size; _i++) {
        stats_graph_fps_data[_i] = 0;
        stats_graph_mem_data[_i] = 0;
    }
}

/// Function to update and insert new data to the graphs arrays.
update_stats_graph = function() {
    var _mem = memory / 1_000_000; // to MB

    array_push(stats_graph_fps_data, fps_real);
    array_push(stats_graph_mem_data, _mem);

    if (array_length(stats_graph_fps_data) > stats_graph_size) {
        array_delete(stats_graph_fps_data, 0, 1); // Clear beginnings
    }
    if (array_length(stats_graph_mem_data) > stats_graph_size) {
        array_delete(stats_graph_mem_data, 0, 1);
    }

    while (stats_graph_mem_max * stats_graph_mem_step < _mem) {
        stats_graph_mem_max ++;
    }
    while (stats_graph_fps_max * stats_graph_fps_step < fps_real) {
        stats_graph_fps_max ++;
    }
}

/// Initialize the graphs
if (stats_on) {
    reset_stats_graph();
}

#endregion Stats
