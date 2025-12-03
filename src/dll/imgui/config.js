const internalSupport = {
    note: "Supported internally",
    supported: true,
}

const XYWrappers = {
    note: "Supported with suffix (X, Y)",
    supported: true,
}

const WHWrappers = {
    note: "Supported with suffix (Width, Height)",
    supported: true,
}


export default {
    apiIgnore: {
        enums: [
            "ImGuiKey",
        ],
    },

    docs: {
        wrappers: {
            "NewFrame": internalSupport,
            "EndFrame": internalSupport,
            "Render": internalSupport,
            "GetDrawData": internalSupport,

            "GetWindowPos": XYWrappers,
            "GetWindowSize": WHWrappers,

            "GetCursorScreenPos": XYWrappers,
            "GetCursorPos": XYWrappers,
            "GetCursorStartPos": XYWrappers,
            "GetMousePos": XYWrappers,
            "GetMousePosOnOpeningCurrentPopup": XYWrappers,
            "GetMouseDragDelta": XYWrappers,
            "GetMouseCursor": internalSupport,

            "DragScalar": {
                note: "Use `ImGui.DragFloatN` or `ImGui.DragIntN`",
                supported: true,
            },
            "SliderScalar": {
                note: "Use `ImGui.SlideFloatN` or `ImGui.SlideIntN`",
                supported: true,
            },
            "InputScalar": {
                note: "Use `ImGui.InputFloatN` or `ImGui.InputIntN`",
                supported: true,
            },

            "GetItemRectMin": XYWrappers,
            "GetItemRectMax": XYWrappers,
            "GetItemRectSize": WHWrappers,

            "CalcTextSize": {
                note: "Use `ImGui.CalcTextWidth` or `ImGui.CalcTextHeight`",
                supported: true,
            },
            "GetStyleColorVec4": {
                note: "Use `ImGui.GetStyleColor`",
                supported: true,
            },

            "UpdatePlatformWindows": internalSupport,
            "UpdatePlatformWindowsDefault": internalSupport,
            "DestroyPlatformWindows": internalSupport,

            "GetWindowContentRegionMax": XYWrappers,
            "GetWindowContentRegionMin": XYWrappers,
            "GetContentRegionMax": XYWrappers,
        },
    },
}