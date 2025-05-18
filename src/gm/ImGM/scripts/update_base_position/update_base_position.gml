function update_base_position(){
    // Base coordinates for the chosen renderer:
    // Positions are relative to monitor top-left, if not using GM renderer.
    // Otherwise relative to window.
    if (ImGui.__GFlags & ImGuiGFlags.GM == 0) { 
        global.imgui_base_x = window_get_x();
        global.imgui_base_y = window_get_y();
    } else {
        global.imgui_base_x = 0;
        global.imgui_base_y = 0;
    }
}