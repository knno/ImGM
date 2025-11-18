# Quick Examples

This page demonstrates how to use ImGM wrappers in a GameMaker project.
Each example shows a minimal setup and highlights common usage patterns.

---

## Simple Window

Create a basic ImGui window with text:

```gml
// Your own object's Step event

ImGui.Begin("Hello Window");
ImGui.Text("Welcome to ImGM!");
ImGui.End();
```

Result: a draggable ImGui window with a single text label.

## Buttons and Interaction

Add a button and respond to clicks:

```gml
// Your own object's Step event

ImGui.Begin("Controls");
if (ImGui.Button("Click Me")) {
    show_debug_message("Button pressed!");
}
ImGui.End();
```

Result: clicking the button prints a message to the debug console.

## Sliders and Variables

Bind ImGui controls to GameMaker variables:

```gml
// Your own object's Create event
my_value = 0.5;

// Your own object's Step event
ImGui.Begin("Settings");
my_value = ImGui.SliderFloat("Adjust Value", my_value, 0.0, 1.0);
ImGui.End();
```

Result: a slider that updates `my_value` between 0.0 and 1.0.

---

## Next Steps
- Explore [Wrappers Manual](api-wrappers.md) for a full list of available functions.
- Review [Styling & Themes](guides-style.md) to customize the look and feel.
- See [Architecture](concept-architecture.md) for how ImGM layers interact.
