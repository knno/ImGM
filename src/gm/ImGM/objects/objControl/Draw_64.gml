///
/// Draw GUI Event
///

// display_set_gui_size(window_get_width(), window_get_height());
// display_set_gui_maximize(1,1,0,0);

/// Draw ImGui (Non-GM RENDERER ONLY)
if (! (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) {
    ImGui.__Draw();
}
