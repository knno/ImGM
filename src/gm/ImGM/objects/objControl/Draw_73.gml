///
/// Draw End Event
///

/// Draw stats

if stats_on { 
    if stats_ui_kind == "GM" draw_stats_gm();
}

/// Draw ImGui (GM RENDERER ONLY)
if (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM) {
    ImGui.__Draw();
}
