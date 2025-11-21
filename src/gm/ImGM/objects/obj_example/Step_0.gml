///
/// Step Event
///

/// Docking
if (global.enable_docking) ImGui.DockSpaceOverViewport();

// Setup
if (!surface_exists(surf)) {
    surf = surface_create(128, 128);
    surface_set_target(surf);
    draw_clear_alpha(c_lime, 0.25);
    surface_reset_target();
}

var base_x = imgm.base_x
var base_y = imgm.base_y

// Adapted from https://gist.github.com/AidanSun05/953f1048ffe5699800d2c92b88c36d9f
if (!docking_inited) {
    var node_id = ImGui.GetID("Primary");
    ImGui.DockBuilderRemoveNode(node_id);
    ImGui.DockBuilderAddNode(node_id);
    var width = window_get_width() / 1.75, height = window_get_height() / 1.5;
    ImGui.DockBuilderSetNodePos(node_id, base_x + (window_get_width() / 2) - (width / 4), base_y + (window_get_height() / 2) - (height / 1.75));
    ImGui.DockBuilderSetNodeSize(node_id, width, height);
    /*
        ImGui.DockBuilderSplitNode creates 3 nodes, one for the parent that contains two children
        0th value is the parent node ID
        1st value is the node that was made in the direction of the split (ie: ImGuiDir.Left would yield the left node here)
        2nd value is the node that was made in the opposing direction of the split (ie: ImGuiDir.Left would yield the right node here)
    */
    var dock1 = ImGui.DockBuilderSplitNode(node_id, ImGuiDir.Left, 0.5);
    node_id = dock1[2];
    dock1 = dock1[0];

    var dock2 = ImGui.DockBuilderSplitNode(node_id, ImGuiDir.Right, 0.25);
    node_id = dock2[2];
    dock2 = dock2[0];

    var dock3 = ImGui.DockBuilderSplitNode(dock2, ImGuiDir.Down, 0.5);
    dock2 = dock3[2];
    dock3 = dock3[0];

    ImGui.DockBuilderDockWindow("ImGM Example", dock1);
    ImGui.DockBuilderDockWindow("Two", dock2);
    ImGui.DockBuilderDockWindow("Three", dock3);
    ImGui.DockBuilderFinish(node_id);
    docking_inited = true;
}

// Main Window
if (main_open) {
    ImGui.SetNextWindowSize(room_width / 2, room_height / 2, ImGuiCond.Once);

    var ret = ImGui.Begin("ImGM Example", main_open, ImGuiWindowFlags.None, ImGuiReturnMask.Both);
    main_open = ret & ImGuiReturnMask.Pointer;

    if (ret & ImGuiReturnMask.Return) {
        var width = ImGui.GetContentRegionAvailX(), height = 256;

        ImGui.BeginChild("Inner_Internal", width, height / 1.5, ImGuiChildFlags.Borders);
            ImGui.Text("Internal");
            ImGui.Separator();
            var _str = "ImGM v" + IMGM_VERSION;
            for(var i = 0, _i = string_length(_str); i < _i; i++) {
                var _c = make_color_hsv(255 * (i / _i), 128, 255);
                ImGui.SetNextItemWidth(string_width(_str));
                ImGui.TextColored(string_char_at(_str, i + 1), _c);
                if (i < _i - 1) ImGui.SameLine(0,2);
            }
            ImGui.TextColored("Improved by knno", #3bb1f8);
            ImGui.Separator();
            ImGui.TextColored("Source URL: ", #3bb1f8);
            ImGui.SameLine(0,0);
            ImGui.TextLinkOpenURL("knno/ImGM", "https://github.com/knno/ImGM");
            ImGui.Separator();
            if (!is_undefined(_static)) {
                _static.__state.Display.Scale = max(0.5, ImGui.InputDouble("Scale", _static.__state.Display.Scale, 0.1, 0.25));
            } else {
                ImGui.BeginDisabled();
                ImGui.InputDouble("ImGui.__Scale", 1);
                ImGui.EndDisabled();
                ImGui.SameLine();
                ImGui.TextColored("(!)", c_red, 1);
                if (ImGui.IsItemHovered()) {
                    ImGui.SetTooltip("Your GameMaker runtime version (" + GM_runtime_version + ") does not support static_get\nPlease update to a newer runtime if possible!");
                }
            }

            if (ImGui.SmallButton("Restart")) {
                game_restart();
            }
        ImGui.EndChild();

        ImGui.BeginChild("Inner_Text", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Text");
            ImGui.Separator();
            ImGui.TextUnformatted("ImGui::TextUnformatted");
            ImGui.Text("ImGui::Text");
            ImGui.TextColored("ImGui::TextColored", col);
            ImGui.TextWrapped("ImGui::TextWrapped - " + string_repeat("A", 24));
            ImGui.TextDisabled("ImGui::TextDisabled");
            ImGui.LabelText("A Label", "ImGui::LabelText");
            ImGui.BulletText("ImGui::BulletText");
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_Buttons", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Buttons");
            ImGui.Separator();
            if (ImGui.Button("ImGui::Button")) show_message_async("nice, you pressed the button");
            if (ImGui.SmallButton("ImGui::SmallButton")) show_message_async("nice, you pressed the smaller button");
            if (ImGui.InvisibleButton("ImGui::InvisibleButton", ImGui.GetContentRegionAvailX(), 24)) show_message_async("nice, you pressed the super secret invisible button");
            if (ImGui.ArrowButton("ImGui::ArrowButton", dir)) dir = (dir + 1) % 4;
            ImGui.SameLine();
            ImGui.Text("Direction: " + string(dir));
            ImGui.ColorButton("ImGui::ColorButton", c_orange, 0.5);
        ImGui.EndChild();

        ImGui.BeginChild("Inner_Textured", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Textured Widgets");
            ImGui.Separator();
            ImGui.Text("ImGui::Image");
            ImGui.Image(spr_example, 0, col2);
            if (ImGui.IsItemHovered()) {
                ImGui.BeginTooltip();
                ImGui.Text("Artwork by @Snoozercreation on Twitter!");
                ImGui.EndTooltip();
            }

            ImGui.Text("ImGui::ImageButton");
            var _col = col4.Color();
            var _cola = col4.Alpha();
            if (ImGui.ImageButton("img_btn", spr_example, 0, c_white, 1, _col, _cola)) {
                show_message_async("nice, you clicked the red panda button :O");
            }

            ImGui.Text("ImGui::Surface");
            surface_set_target(surf);
            var xx, yy;
            if (ImGui.__GFlags & ImGuiGFlags.GM == 0) {
                xx = display_mouse_get_x() - ImGui.GetCursorScreenPosX();
                yy = display_mouse_get_y() - ImGui.GetCursorScreenPosY();
            } else {
                xx = window_mouse_get_x() - ImGui.GetCursorScreenPosX();
                yy = window_mouse_get_y() - ImGui.GetCursorScreenPosY();
            }
            var c = make_colour_hsv(255 * ((current_time % 1000) / 1000), 128, 255);
            draw_circle_color(xx, yy, 4, c, c, false);
            surface_reset_target();
            ImGui.Surface(surf);
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_Tree", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Tree");
            ImGui.Separator();
            if (ImGui.TreeNode("ImGui::TreeNode")) {
                ImGui.Text("Hello!\nThis is some content inside of a tree node :)");
                ImGui.TreePop();
            }

            if (ImGui.TreeNode("Another Node")) {
                ImGui.Text("This is another tree node, for the sake of example!");
                ImGui.Image(spr_example, 0, c_red, 1, sprite_get_width(spr_example) / 2, sprite_get_height(spr_example) / 2);
                ImGui.TreePop();
            }

            ret = ImGui.CollapsingHeader("ImGui::CollapsingHeader", header_visible, undefined, ImGuiReturnMask.Both);
            header_visible = ret & ImGuiReturnMask.Pointer;
            if (ret & ImGuiReturnMask.Return) {
                ImGui.TextColored("hewwo", c_aqua, 0.5);
                ImGui.Text("You can click the X icon at the side of the header to hide it!");
            }

            if (!header_visible) {
                if (ImGui.Button("Restore Header")) {
                    header_visible = true;
                }
            }
        ImGui.EndChild();

		ImGui.BeginChild("Inner_Sliders", width / 2, height, ImGuiChildFlags.Borders);
			ImGui.Text("Sliders");
			ImGui.Separator();

			slider_int = ImGui.SliderInt("ImGui::SliderInt", slider_int, 0, 10);
			ImGui.SliderInt2("ImGui::SliderInt2", slider_int2, 0, 10);
			ImGui.SliderInt3("ImGui::SliderInt3", slider_int3, 0, 10);
			ImGui.SliderInt4("ImGui::SliderInt4", slider_int4, 0, 10);
			ImGui.SliderIntN("ImGui::SliderIntN", slider_intn, 0, 10);

			slider_float = ImGui.SliderFloat("ImGui::SliderFloat", slider_float, 0.0, 1.0);
		ImGui.EndChild();

        ImGui.BeginChild("Inner_Inputs", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Inputs");
            ImGui.Separator();

            input_val = ImGui.InputText("ImGui::InputText", input_val);
            input_val_ml = ImGui.InputTextMultiline("ImGui::InputTextMultiline", input_val_ml);
            input_hint = ImGui.InputTextWithHint("ImGui::InputTextWithHint", "This input has a hint value! It disappears whenever you enter something", input_hint);

            input_int = ImGui.InputInt("ImGui::InputInt", input_int, 1, 5);
            input_float = ImGui.InputFloat("ImGui::InputFloat", input_float, 0.1, 0.5);
            ImGui.InputFloat4("ImGui::InputFloat4", input_float4, 0.1, 0.5);
            ImGui.EndChild();

            ImGui.SameLine();

            ImGui.BeginChild("Inner_Colors", 0, height, ImGuiChildFlags.Borders);
            ImGui.Text("Colors");
            ImGui.Separator();

            col3 = ImGui.ColorPicker3("ImGui::ColorPicker3", col3);
            ImGui.Separator();
            ImGui.ColorPicker4("ImGui::ColorPicker4", col4);
            ImGui.Separator();
            col5 = ImGui.ColorEdit3("ImGui::ColorEdit3", col5);
            ImGui.Separator();
            ImGui.ColorEdit4("ImGui::ColorEdit4", col6);
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_Table", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Tables");
            ImGui.Separator();
            if (ImGui.BeginTable("table_test", 3)) {
                ImGui.TableSetupColumn("One");
                ImGui.TableSetupColumn("Two");
                ImGui.TableSetupColumn("Three");
                ImGui.TableHeadersRow();

                for(var i = 0; i < 5; i++) {
                    ImGui.TableNextRow();
                    for(var j = 0; j < 3; j++) {
                        ImGui.TableSetColumnIndex(j);
                        ImGui.TableSetBgColor(ImGuiTableBgTarget.CellBg, make_color_hsv(255 * ((i + j) / 8), 128, 255), j);
                        ImGui.Text("Hello " + string(i + j));
                    }
                }

                ImGui.EndTable();
            }
        ImGui.EndChild();

        ImGui.BeginChild("Inner_Tabs", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Tabs");
            ImGui.Separator();
            if (ImGui.BeginTabBar("MyTabBar"))
            {
                ret = ImGui.BeginTabItem("Closable", tab1, undefined, ImGuiReturnMask.Both);
                tab1 = ret & ImGuiReturnMask.Pointer;
                if (ret & ImGuiReturnMask.Return) {
                    ImGui.Text("This is a closable tab!\nblah blah blah blah blah");
                    ImGui.EndTabItem();
                }

                if (ImGui.BeginTabItem("Avocado"))
                {
                    ImGui.Text("This is the Avocado tab!\nblah blah blah blah blah");
                    ImGui.EndTabItem();
                }
                if (ImGui.BeginTabItem("Broccoli"))
                {
                    ImGui.Text("This is the Broccoli tab!\nblah blah blah blah blah");
                    ImGui.EndTabItem();
                }
                if (ImGui.BeginTabItem("Cucumber"))
                {
                    ImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah");
                    ImGui.EndTabItem();
                }
                ImGui.EndTabBar();
            }
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_Plots", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Plots");
            ImGui.Separator();
            ImGui.PlotLines("Line Plot", plot_val);
            ImGui.PlotHistogram("Histogram Plot", plot_val2, 0, "Overlay Here!", undefined, undefined, undefined, 128);
        ImGui.EndChild();

        ImGui.BeginChild("Inner_Dock", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Dock Space");
            ImGui.Separator();
            var space_id = ImGui.GetID("MyDockSpace");
            ImGui.Text("You can drag any window into the space below to dock it!");
            ImGui.DockSpace(space_id); // Windows created later on can be docked.
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_DragDrop", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Drag and Drop");
            ImGui.Separator();
            if (ImGui.RadioButton("Copy", drag_mode == 0)) {drag_mode = 0;} ImGui.SameLine();
            if (ImGui.RadioButton("Move", drag_mode == 1)) {drag_mode = 1;} ImGui.SameLine();
            if (ImGui.RadioButton("Swap", drag_mode == 2)) {drag_mode = 2;}

            for(var i = 0; i < array_length(drag_names); i++) {
                ImGui.PushID(i);
                if (i % 3 != 0) {
                    ImGui.SameLine();
                }

                ImGui.Button(drag_names[i], 60, 60);
                if (ImGui.BeginDragDropSource()) {
                    ImGui.SetDragDropPayload("DND_DEMO_CELL", i);

                    var verb = "Copy";
                    switch (drag_mode) {
                        case 1: verb = "Move"; break;
                        case 2: verb = "Swap"; break;
                    }
                    ImGui.Text(verb + " " + string(drag_names[i]));
                    ImGui.EndDragDropSource();
                }

                if (ImGui.BeginDragDropTarget()) {
                    var payload = ImGui.AcceptDragDropPayload("DND_DEMO_CELL");
                    if (payload != undefined) {
                        switch (drag_mode) {
                            // Copy
                            case 0: {
                                drag_names[i] = drag_names[payload];
                                break;
                            }

                            // Move
                            case 1: {
                                drag_names[i] = drag_names[payload];
                                drag_names[payload] = "";
                                break;
                            }

                            // Swap
                            case 2: {
                                var temp = drag_names[i];
                                drag_names[i] = drag_names[payload];
                                drag_names[payload] = temp;
                                break;
                            }
                        }
                    }
                    ImGui.EndDragDropTarget();
                }
                ImGui.PopID();
            }
        ImGui.EndChild();

        ImGui.BeginChild("Inner_Fonts", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Fonts");
            ImGui.Separator();
            ImGui.Text("You can load TTF/OTF font files from disk!");
            ImGui.PushFont(global.font_roboto);
            ImGui.TextColored("And use them wherever!", c_aqua);
            ImGui.Text("Pretty neat, right?!");
            ImGui.PopFont();
            ImGui.Text("And back to the default font ^_^");
        ImGui.EndChild();

        ImGui.SameLine();

        ImGui.BeginChild("Inner_DrawLists", width / 2, height, ImGuiChildFlags.Borders);
            ImGui.Text("Drawlists");
            ImGui.Separator();
            var list = ImGui.GetWindowDrawList();
            xx = ImGui.GetCursorScreenPosX();
            yy = ImGui.GetCursorScreenPosY();
            ImGui.DrawListAddText(list, xx + (width / 4), yy + 4, "Hello from DrawListAddText!", col2);
            ImGui.DrawListAddCircleFilled(list, xx + 52, yy + 32, 12, c_blue);
            ImGui.DrawListAddBezierCubic(list, xx + 4, yy + 4, xx + (width / 4), yy + 24, xx + (width / 4) + 32, yy + 48, xx + (width / 4) + 24, yy + 64, c_purple, 3);
            var ix = xx + 24, iy = yy + (height / 3), iw = sprite_get_width(spr_example2), ih = sprite_get_height(spr_example2);
            ImGui.DrawListAddImageRounded(list, spr_example2, current_time / 100, ix - (iw / 2), iy - (ih / 2), ix + (iw / 2), iy + (ih / 2), c_white, 32, ImDrawFlags.None);
            ImGui.DrawListAddNgonFilled(list, xx + (width / 4), yy + (height / 2), 64, c_aqua, 5);
        ImGui.EndChild();
    }
    ImGui.End();
}

ImGui.Begin("Two");
ImGui.Text("These windows are docked inside of a dockspace via the DockBuilder API");
ImGui.End();
ImGui.Begin("Three");
ImGui.TextColored("You can choose to include specific windows inside of split dock nodes!", c_yellow);
ImGui.End();

// GM Demo
if (demo_open) {
    if (demo_imgui) {
        demo_imgui = ImGui.ShowDemoWindow(demo_imgui);
    }
    ImGui.SetNextWindowPos(base_x+30, base_y+350, ImGuiCond.FirstUseEver);
    ImGui.SetNextWindowSize(300,200, ImGuiCond.FirstUseEver);
    ImGui.Begin("Demos");
    if (demo_multi_select) {
        if (ImGui.TreeNode("Multi-Select")) {
            ImGui.Text("Supported features:");
            ImGui.BulletText("Keyboard navigation (arrows, page up/down, home/end, space).");
            ImGui.BulletText("Ctrl modifier to preserve and toggle selection.");
            ImGui.BulletText("Shift modifier for range selection.");
            ImGui.BulletText("CTRL+A to select all.");
            ImGui.BulletText("Escape to clear selection.");
            ImGui.BulletText("Click and drag to box-select.");

            ImGui.Text(string("Selection: {0}/{1}", multi_select_selection.GetSize(), multi_select_selection_size));

            if (ImGui.BeginChild("##Basket", -1, ImGui.GetFontSize() * 20, ImGuiChildFlags.FrameStyle | ImGuiChildFlags.ResizeY)) {
                var flags = ImGuiMultiSelectFlags.ClearOnEscape | ImGuiMultiSelectFlags.BoxSelect1d;
                var ms_io = ImGui.BeginMultiSelect(flags, multi_select_selection.GetSize(), multi_select_selection_size);
                multi_select_selection.ApplyRequests(ms_io);

                var label, item_is_selected;
                for (var n = 0; n < multi_select_selection_size; n++) {
                    label = string("Object {0}: {1}", n, sample_names[n % array_length(sample_names)]);
                    item_is_selected = multi_select_selection.Contains(n);
                    ImGui.SetNextItemSelectionUserData(n);
                    ImGui.Selectable(label, item_is_selected);
                }
                ms_io = ImGui.EndMultiSelect();
                multi_select_selection.ApplyRequests(ms_io);
            }
            ImGui.EndChild();
            ImGui.TreePop();
        }
    }
    ImGui.End();
}
