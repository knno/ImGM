///
/// Create event
///

imgm = __ImGM();

// Demos
demo_imgui = false; // ImGui demo window
demo_open = true;
    demo_multi_select = true;
	demo_extensions = true;
		ext_text_editor_open = false;
        ext_node_editor_open = false;

// MultiSelect
multi_select_selection_size = 40;
multi_select_selection = new ImGuiSelectionBasicStorage();

text_editor = undefined;

text_editor_langs = ["C++", "HLSL", "GLSL", "Lua", "GML"];
text_editor_langs_array = [ImTextEditorLanguage.CPlusPlus, ImTextEditorLanguage.HLSL, ImTextEditorLanguage.GLSL, ImTextEditorLanguage.Lua, ImTextEditorLanguage.GML];
text_editor_palettes = ["Dark", "Light", "RetroBlue", "GameMaker"]
text_editor_palettes_array = [ImTextEditorPalette.Dark, ImTextEditorPalette.Light, ImTextEditorPalette.RetroBlue, ImTextEditorPalette.GameMaker];
text_editor_lang_selected = 4;
text_editor_palette_selected = 3;

node_editor = undefined;
node_editor_first_frame = true;
node_editor_uniqueId = 1;
node_editor_nodeA_Id = node_editor_uniqueId++;
node_editor_nodeA_inputPinId = node_editor_uniqueId++;
node_editor_nodeA_outputPinId = node_editor_uniqueId++;
node_editor_nodeB_Id = node_editor_uniqueId++;
node_editor_nodeB_inputPinId = node_editor_uniqueId++;
node_editor_nodeB_outputPinId = node_editor_uniqueId++;
node_editor_links = [{id: node_editor_uniqueId++, in: node_editor_nodeB_inputPinId, out: node_editor_nodeA_outputPinId}];

randomize();

// Samples
sample_names = [
    "Artichoke", "Arugula", "Asparagus", "Avocado", "Bamboo Shoots", "Bean Sprouts", "Beans", "Beet", "Belgian Endive", "Bell Pepper",
    "Bitter Gourd", "Bok Choy", "Broccoli", "Brussels Sprouts", "Burdock Root", "Cabbage", "Calabash", "Capers", "Carrot", "Cassava",
    "Cauliflower", "Celery", "Celery Root", "Celcuce", "Chayote", "Chinese Broccoli", "Corn", "Cucumber"
];

docking_inited = false; // Set up docking
main_open = true; // Main window
header_visible = true;
tab1 = true;

str_ohayo = "おはよう"; // Japanese text
str_marhaba = "مرحبا" // Arabic text (buggy BIDI and letter connections) // Or chr(0x0645) + chr(0x0631) + chr(0x062D) + chr(0x0628) + chr(0x0627)

_static = undefined;
try {
    _static = static_get(ImGui);
} catch (e) {
    _static = undefined;
}


col = c_blue;                     // for TextColored
col2 = c_white;                   // for Image & ColorPicker
col3 = c_lime;                    // for ColorPicker3
col4 = new ImColor(c_aqua, 0.5);  // for ColorPicker4
col5 = c_fuchsia;
col6 = new ImColor(irandom(255), irandom(255), irandom(255), random(1));
dir = ImGuiDir.Right;             // for ArrowButton

surf = -1;                        // for Surface

input_val = "This is a text input! You can type things here! Or even paste new text!";        // for InputText
input_val_ml = "This is a multiline input!\nBelieve it or not, you can have multiple lines here.\n\nPretty neat, right?";
input_hint = "";

input_int = irandom(255);
input_float = random(255);
input_float4 = [1.0, 2.0, 3.0, 4.0];

slider_int = 0;
slider_int2 = [];
slider_int3 = [];
slider_int4 = [];
slider_intn = [0,1];
slider_float = 0.0;
slider_angle = pi;

plot_val = [];
plot_val2 = [];
repeat(12) {
    array_push(plot_val, irandom(255));
    array_push(plot_val2, irandom(255));
}

drag_mode = 0;
drag_names = [
    "Bobby", "Beatrice", "Betty",
    "Brianna", "Barry", "Bernard",
    "Bibi", "Blaine", "Bryn"
];
