/// Use this script (or Extras/ImExt<name>_Extras) for additional or custom helpers.
/// These functions will be parsed and included in the generatable docs.

#region Example

/*

/// JSDOC
 **
 * @function my_custom_function_name
 * @description Creates a foo table
 * @param {String} _label The ImGui label
 * @param {String} title
 * @param {Array<Real>} _data_array
 * @param {Bool} [enabled]
 * @return {Undefined}
 * @context ImGui
 *
function my_custom_function_name(_label, title, _data_array, enabled=true) {
    ...
}

*/


#endregion

#region UI

/**
 * @function is_window_in_gm_window
 * @description Returns true if the ImGui window is docked inside the main GM window.
 * @param {String} window_name The name of the ImGui window to check.
 * @return {bool}
 *
 */
function is_window_in_gm_window(window_name) {
    var viewport = ImGui.GetWindowViewport(window_name);
    if (viewport == undefined || viewport == -1) return false;

    var main_viewport = ImGui.GetMainViewport();
    if (main_viewport == undefined || main_viewport == -1) return false;

    return (viewport == main_viewport);
}


#endregion

#region Graphics

/**
 * @function plot_lines_with_grid
 * @description Draws a graph (with grid background)
 * @param {String} _label
 * @param {Array<Real>} _data_array
 * @param {Real} _offset
 * @param {String} _overlay
 * @param {Real} _min_val
 * @param {Real} _max_val
 * @param {Real} _width
 * @param {Real} _height
 * @param {Real} _h_lines
 * @param {Real} _v_lines
 * @return {Undefined}
 * @author knno
 * @see {ImGui.PlotLines}
 * @context ImGui
 *
 */
function plot_lines_with_grid(_label, _data_array, _offset, _overlay, _min_val, _max_val, _width, _height, _h_lines, _v_lines=1) {
    var _cursor_pos_x = ImGui.GetCursorScreenPosX();
    var _cursor_pos_y = ImGui.GetCursorScreenPosY();
    var _draw_list = ImGui.GetWindowDrawList();
    var _grid_color = c_dkgray;
    var _text_color = c_gray;
    var _plot_pos_min = {x: _cursor_pos_x, y: _cursor_pos_y};
    var _plot_pos_max = {x: _plot_pos_min.x + _width, y: _plot_pos_min.y + _height};

    for (var _i = 0; _i <= _v_lines; _i++) {
        var _y = lerp(_plot_pos_min.y, _plot_pos_max.y, _i / _v_lines);
        ImGui.DrawListAddLine(_draw_list, _plot_pos_min.x, _y, _plot_pos_max.x, _y, _grid_color, 1.0);
        var _marker_value = lerp(_min_val, _max_val, 1.0 - (_i / _v_lines)); // Reversed because of graph origin
        ImGui.SetCursorPosX(_width - ImGui.CalcTextWidth(_marker_value));
        ImGui.DrawListAddText(_draw_list, _plot_pos_min.x - 35, _y - 2, floor(_marker_value), _text_color);
    }

    for (var _i = 0; _i <= _h_lines; _i++) {
        var _x = lerp(_plot_pos_min.x, _plot_pos_max.x, _i / _h_lines);
        ImGui.DrawListAddLine(_draw_list, _x, _plot_pos_min.y, _x, _plot_pos_max.y, _grid_color, 1.0);
        var _marker_value = lerp(0, array_length(_data_array), _i / _h_lines); // x-axis represents indices ig.
        ImGui.DrawListAddText(_draw_list, _x, _plot_pos_max.y + 5, floor(_marker_value), _text_color);
    }
    ImGui.SetCursorScreenPos(_plot_pos_min.x, _plot_pos_min.y);
    ImGui.PlotLines(_label, _data_array, _offset, _overlay, _min_val, _max_val, _width, _height);
}

#endregion