/// Use this script <name>_Extras for additional standalone helpers for ImGui:
/// These functions will be parsed and included in the docs.

#region Plot

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