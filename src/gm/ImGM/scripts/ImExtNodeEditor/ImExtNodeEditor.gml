/// Feather ignore GM1003
/// Feather ignore GM1014
/// Feather ignore GM1019
/// Feather ignore GM1045

function ImExtNodeEditor() constructor {
    /// @section Binds
    /// @function CreateEditor
    /// @description Wrapper function for NodeEditor.
    /// @param {String|Undefined} [config_file=undefined]
    /// @context ImExtNodeEditor
    /// @return {ImExtNodeEditorContext}
    static CreateEditor = function(config_file=undefined) {
        return __imext_node_editor_create_editor(config_file);
    }
    /// @endsection

    /// @section Enums
    enum ImCubicBezierSubdivideFlags {
        None = 0,
        SkipFirst = 1,
    }
    /// @endsection

    /// @section Internal
    static __Initialized = false;

    static Initialize = function() {
        ImExtNodeEditor.__Initialized = true;
    }

    static __NewFrame = function(state=undefined) {
    }

    /// autocalls
    __ImGui_NewFrame = method(self, function(state) {
        return __NewFrame(state); // self
    })
    /// @endsection
}
