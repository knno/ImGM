export default {
    apiIgnore: {
        enums: [
        ],
    },

    docs: {
        wrappers: {
            "SetLanguageDefinition": {
                note: 'Use `editor.SetLanguage`',
                supported: true,
            },
            "GetPalette": {
                note: 'Use `editor.GetPaletteColor`',
                supported: true,
            },
            "GetCursorPosition": {
                note: "Supported with suffix (Line, Column)",
                supported: true,
            },
            "SetSelection": {
                note: "Use `editor.SelectLine`",
                supported: true,
            },
        },
    },
}