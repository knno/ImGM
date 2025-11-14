/// @description Draw End Event

if (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM) {
    ImGui.__Draw(); // Draw normally when using GM renderer.
}
