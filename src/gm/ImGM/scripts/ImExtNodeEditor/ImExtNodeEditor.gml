/// Feather ignore GM1003
/// Feather ignore GM1014
/// Feather ignore GM1019
/// Feather ignore GM1045

function ImExtNodeEditor() constructor {
    #region Binds

    #endregion

    #region Enums

    #endregion

    #region Internal
    static __initialized = false;

    static Initialize = function() {
        ImExtNodeEditor.__initialized = true;
    }

    static __NewFrame = function(state=undefined) {
    }

    /// autocalls
	__ImGui_Initialize = method(self, function(state) {
		return Initialize();
	})

    __ImGui_NewFrame = method(self, function(state) {
        return __NewFrame(state); // self
    })

    #endregion
}
