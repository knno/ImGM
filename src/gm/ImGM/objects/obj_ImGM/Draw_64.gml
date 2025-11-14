/// @description Draw GUI Event

if (! (ImGui.__GFlags & ImGuiGFlags.RENDERER_GM)) {
    ImGui.__Draw(); // Draw (GUI event) when using non-GM renderer only.
}
