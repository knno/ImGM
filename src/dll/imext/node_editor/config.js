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
        ],
    },

    docs: {
        wrappers: {
            "GetGroupMin": XYWrappers,
            "GetGroupMax": XYWrappers,
            "GetNodePosition": XYWrappers,
            "GetNodeSize": WHWrappers,
            "GetScreenSize": XYWrappers,
            "ScreenToCanvas": XYWrappers,
            "CanvasToScreen": XYWrappers,
            "BreakLinks": XYWrappers,
            "HasAnyLinks": {
                note: "Supported with suffix (Node, Pin)",
                supported: true,
            },
        },
    },
}