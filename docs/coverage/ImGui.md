# ImGui Coverage

**Coverage:** 90% (379/419)


## Wrappers

These are the wrappers of functions generated for ImGui.

| Wrapper | Covered | Wrapper Location | Note |
|---------|---------|------------------|------|
| `ImGui.CreateContext` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L5) | - |
| `ImGui.DestroyContext` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L10) | - |
| `ImGui.GetCurrentContext` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L17) | - |
| `ImGui.SetCurrentContext` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L22) | - |
| `ImGui.GetIO` | ❌ | - | - |
| `ImGui.GetPlatformIO` | ❌ | - | - |
| `ImGui.GetStyle` | ❌ | - | - |
| `ImGui.NewFrame` | ✅ | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L142) | Supported internally |
| `ImGui.EndFrame` | ✅ | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L172) | Supported internally |
| `ImGui.Render` | ✅ | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L184) | Supported internally |
| `ImGui.GetDrawData` | ✅ | - | Supported internally |
| `ImGui.ShowDemoWindow` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L29) | - |
| `ImGui.ShowMetricsWindow` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L45) | - |
| `ImGui.ShowDebugLogWindow` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L61) | - |
| `ImGui.ShowIDStackToolWindow` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L77) | - |
| `ImGui.ShowAboutWindow` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L95) | - |
| `ImGui.ShowStyleEditor` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L111) | - |
| `ImGui.ShowStyleSelector` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L116) | - |
| `ImGui.ShowFontSelector` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L123) | - |
| `ImGui.ShowUserGuide` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L130) | - |
| `ImGui.GetVersion` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L135) | - |
| `ImGui.StyleColorsDark` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L3) | - |
| `ImGui.StyleColorsLight` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L8) | - |
| `ImGui.StyleColorsClassic` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L13) | - |
| `ImGui.Begin` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L3) | - |
| `ImGui.End` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L24) | - |
| `ImGui.BeginChild` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L29) | - |
| `ImGui.EndChild` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L44) | - |
| `ImGui.IsWindowAppearing` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L67) | - |
| `ImGui.IsWindowCollapsed` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L72) | - |
| `ImGui.IsWindowFocused` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L77) | - |
| `ImGui.IsWindowHovered` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L85) | - |
| `ImGui.GetWindowDrawList` | ✅ | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L32) | - |
| `ImGui.GetWindowDpiScale` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L93) | - |
| `ImGui.GetWindowPos` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetWindowSize` | ✅ | - | Supported with suffix (Width, Height) |
| `ImGui.GetWindowWidth` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L112) | - |
| `ImGui.GetWindowHeight` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L117) | - |
| `ImGui.GetWindowViewport` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L122) | - |
| `ImGui.SetNextWindowPos` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L143) | - |
| `ImGui.SetNextWindowSize` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L157) | - |
| `ImGui.SetNextWindowSizeConstraints` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L167) | - |
| `ImGui.SetNextWindowContentSize` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L178) | - |
| `ImGui.SetNextWindowCollapsed` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L186) | - |
| `ImGui.SetNextWindowFocus` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L195) | - |
| `ImGui.SetNextWindowScroll` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L200) | - |
| `ImGui.SetNextWindowBgAlpha` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L209) | - |
| `ImGui.SetNextWindowViewport` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L135) | - |
| `ImGui.SetWindowPos` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L285) | - |
| `ImGui.SetWindowSize` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L302) | - |
| `ImGui.SetWindowCollapsed` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L319) | - |
| `ImGui.SetWindowFocus` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L334) | - |
| `ImGui.GetScrollX` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L216) | - |
| `ImGui.GetScrollY` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L221) | - |
| `ImGui.SetScrollX` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L226) | - |
| `ImGui.SetScrollY` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L233) | - |
| `ImGui.GetScrollMaxX` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L240) | - |
| `ImGui.GetScrollMaxY` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L245) | - |
| `ImGui.SetScrollHereX` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L250) | - |
| `ImGui.SetScrollHereY` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L258) | - |
| `ImGui.SetScrollFromPosX` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L266) | - |
| `ImGui.SetScrollFromPosY` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L275) | - |
| `ImGui.PushFont` | ✅ | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L9) | - |
| `ImGui.PopFont` | ✅ | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L21) | - |
| `ImGui.GetFont` | ✅ | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L4) | - |
| `ImGui.GetFontSize` | ✅ | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L90) | - |
| `ImGui.GetFontBaked` | ❌ | - | - |
| `ImGui.PushStyleColor` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L18) | - |
| `ImGui.PopStyleColor` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L27) | - |
| `ImGui.PushStyleVar` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L35) | - |
| `ImGui.PushStyleVarX` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L49) | - |
| `ImGui.PushStyleVarY` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L60) | - |
| `ImGui.PopStyleVar` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L71) | - |
| `ImGui.PushItemFlag` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L169) | - |
| `ImGui.PopItemFlag` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L179) | - |
| `ImGui.PushItemWidth` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L221) | - |
| `ImGui.PopItemWidth` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L228) | - |
| `ImGui.SetNextItemWidth` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L233) | - |
| `ImGui.CalcItemWidth` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L240) | - |
| `ImGui.PushTextWrapPos` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L245) | - |
| `ImGui.PopTextWrapPos` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L253) | - |
| `ImGui.GetFontTexUvWhitePixel` | ❌ | - | - |
| `ImGui.GetColorU32` | ❌ | - | - |
| `ImGui.GetStyleColorVec4` | ✅ | - | Use `ImGui.GetStyleColor` |
| `ImGui.GetCursorScreenPos` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.SetCursorScreenPos` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L115) | - |
| `ImGui.GetContentRegionAvail` | ❌ | - | - |
| `ImGui.GetCursorPos` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetCursorPosX` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L77) | - |
| `ImGui.GetCursorPosY` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L82) | - |
| `ImGui.SetCursorPos` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L123) | - |
| `ImGui.SetCursorPosX` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L131) | - |
| `ImGui.SetCursorPosY` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L138) | - |
| `ImGui.GetCursorStartPos` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.Separator` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L28) | - |
| `ImGui.SameLine` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L57) | - |
| `ImGui.NewLine` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L18) | - |
| `ImGui.Spacing` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L5) | - |
| `ImGui.Dummy` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L10) | - |
| `ImGui.Indent` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L41) | - |
| `ImGui.Unindent` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L49) | - |
| `ImGui.BeginGroup` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L67) | - |
| `ImGui.EndGroup` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L72) | - |
| `ImGui.AlignTextToFramePadding` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L23) | - |
| `ImGui.GetTextLineHeight` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L145) | - |
| `ImGui.GetTextLineHeightWithSpacing` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L150) | - |
| `ImGui.GetFrameHeight` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L155) | - |
| `ImGui.GetFrameHeightWithSpacing` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L160) | - |
| `ImGui.PushID` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L142) | - |
| `ImGui.PopID` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L155) | - |
| `ImGui.GetID` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L161) | - |
| `ImGui.TextUnformatted` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L3) | - |
| `ImGui.Text` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L10) | - |
| `ImGui.TextV` | ❌ | - | - |
| `ImGui.TextColored` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L17) | - |
| `ImGui.TextColoredV` | ❌ | - | - |
| `ImGui.TextDisabled` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L27) | - |
| `ImGui.TextDisabledV` | ❌ | - | - |
| `ImGui.TextWrapped` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L34) | - |
| `ImGui.TextWrappedV` | ❌ | - | - |
| `ImGui.LabelText` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L41) | - |
| `ImGui.LabelTextV` | ❌ | - | - |
| `ImGui.BulletText` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L49) | - |
| `ImGui.BulletTextV` | ❌ | - | - |
| `ImGui.SeparatorText` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L33) | - |
| `ImGui.Button` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L5) | - |
| `ImGui.SmallButton` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L16) | - |
| `ImGui.InvisibleButton` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L23) | - |
| `ImGui.ArrowButton` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L36) | - |
| `ImGui.Checkbox` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L110) | - |
| `ImGui.CheckboxFlags` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L119) | - |
| `ImGui.RadioButton` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L129) | - |
| `ImGui.ProgressBar` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L137) | - |
| `ImGui.Bullet` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L150) | - |
| `ImGui.TextLink` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L155) | - |
| `ImGui.TextLinkOpenURL` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L163) | - |
| `ImGui.Image` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L45) | - |
| `ImGui.ImageWithBg` | ❌ | - | - |
| `ImGui.ImageButton` | ✅ | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L66) | - |
| `ImGui.BeginCombo` | ✅ | [imgui_combo_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_combo_gm.cpp#L3) | - |
| `ImGui.EndCombo` | ✅ | [imgui_combo_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_combo_gm.cpp#L12) | - |
| `ImGui.Combo` | ✅ | [imgui_combo_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_combo_gm.cpp#L17) | - |
| `ImGui.DragFloat` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L3) | - |
| `ImGui.DragFloat2` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L22) | - |
| `ImGui.DragFloat3` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L46) | - |
| `ImGui.DragFloat4` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L70) | - |
| `ImGui.DragFloatRange2` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L121) | - |
| `ImGui.DragInt` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L146) | - |
| `ImGui.DragInt2` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L165) | - |
| `ImGui.DragInt3` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L189) | - |
| `ImGui.DragInt4` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L213) | - |
| `ImGui.DragIntRange2` | ✅ | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L264) | - |
| `ImGui.DragScalar` | ✅ | - | Use `ImGui.DragFloatN` or `ImGui.DragIntN` |
| `ImGui.DragScalarN` | ❌ | - | - |
| `ImGui.SliderFloat` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L3) | - |
| `ImGui.SliderFloat2` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L20) | - |
| `ImGui.SliderFloat3` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L42) | - |
| `ImGui.SliderFloat4` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L64) | - |
| `ImGui.SliderAngle` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L259) | - |
| `ImGui.SliderInt` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L113) | - |
| `ImGui.SliderInt2` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L130) | - |
| `ImGui.SliderInt3` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L152) | - |
| `ImGui.SliderInt4` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L174) | - |
| `ImGui.SliderScalar` | ✅ | - | Use `ImGui.SlideFloatN` or `ImGui.SlideIntN` |
| `ImGui.SliderScalarN` | ❌ | - | - |
| `ImGui.VSliderFloat` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L221) | - |
| `ImGui.VSliderInt` | ✅ | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L240) | - |
| `ImGui.VSliderScalar` | ❌ | - | - |
| `ImGui.InputText` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L3) | - |
| `ImGui.InputTextMultiline` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L16) | - |
| `ImGui.InputTextWithHint` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L33) | - |
| `ImGui.InputFloat` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L47) | - |
| `ImGui.InputFloat2` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L64) | - |
| `ImGui.InputFloat3` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L86) | - |
| `ImGui.InputFloat4` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L108) | - |
| `ImGui.InputInt` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L155) | - |
| `ImGui.InputInt2` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L170) | - |
| `ImGui.InputInt3` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L186) | - |
| `ImGui.InputInt4` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L202) | - |
| `ImGui.InputDouble` | ✅ | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L237) | - |
| `ImGui.InputScalar` | ✅ | - | Use `ImGui.InputFloatN` or `ImGui.InputIntN` |
| `ImGui.InputScalarN` | ❌ | - | - |
| `ImGui.ColorEdit3` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L6) | - |
| `ImGui.ColorEdit4` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L30) | - |
| `ImGui.ColorPicker3` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L18) | - |
| `ImGui.ColorPicker4` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L60) | - |
| `ImGui.ColorButton` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L90) | - |
| `ImGui.SetColorEditOptions` | ✅ | [imgui_color_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_color_gm.cpp#L106) | - |
| `ImGui.TreeNode` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L3) | - |
| `ImGui.TreeNodeV` | ❌ | - | - |
| `ImGui.TreeNodeEx` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L10) | - |
| `ImGui.TreeNodeExV` | ❌ | - | - |
| `ImGui.TreePush` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L19) | - |
| `ImGui.TreePop` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L26) | - |
| `ImGui.GetTreeNodeToLabelSpacing` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L31) | - |
| `ImGui.CollapsingHeader` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L45) | - |
| `ImGui.SetNextItemOpen` | ✅ | [imgui_tree_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tree_gm.cpp#L36) | - |
| `ImGui.SetNextItemStorageID` | ❌ | - | - |
| `ImGui.Selectable` | ✅ | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L4) | - |
| `ImGui.BeginMultiSelect` | ✅ | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L45) | - |
| `ImGui.EndMultiSelect` | ✅ | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L77) | - |
| `ImGui.SetNextItemSelectionUserData` | ✅ | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L85) | - |
| `ImGui.IsItemToggledSelection` | ✅ | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L19) | - |
| `ImGui.BeginListBox` | ✅ | [imgui_listbox_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_listbox_gm.cpp#L3) | - |
| `ImGui.EndListBox` | ✅ | [imgui_listbox_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_listbox_gm.cpp#L14) | - |
| `ImGui.ListBox` | ✅ | [imgui_listbox_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_listbox_gm.cpp#L19) | - |
| `ImGui.PlotLines` | ✅ | [imgui_plots_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_plots_gm.cpp#L3) | - |
| `ImGui.PlotHistogram` | ✅ | [imgui_plots_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_plots_gm.cpp#L27) | - |
| `ImGui.Value` | ✅ | [imgui_text_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_text_gm.cpp#L56) | - |
| `ImGui.BeginMenuBar` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L3) | - |
| `ImGui.EndMenuBar` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L8) | - |
| `ImGui.BeginMainMenuBar` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L13) | - |
| `ImGui.EndMainMenuBar` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L18) | - |
| `ImGui.BeginMenu` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L23) | - |
| `ImGui.EndMenu` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L32) | - |
| `ImGui.MenuItem` | ✅ | [imgui_menu_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_menu_gm.cpp#L37) | - |
| `ImGui.BeginTooltip` | ✅ | [imgui_tooltips_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tooltips_gm.cpp#L3) | - |
| `ImGui.EndTooltip` | ✅ | [imgui_tooltips_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tooltips_gm.cpp#L8) | - |
| `ImGui.SetTooltip` | ✅ | [imgui_tooltips_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tooltips_gm.cpp#L13) | - |
| `ImGui.SetTooltipV` | ❌ | - | - |
| `ImGui.BeginItemTooltip` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L322) | - |
| `ImGui.SetItemTooltip` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L327) | - |
| `ImGui.SetItemTooltipV` | ❌ | - | - |
| `ImGui.BeginPopup` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L3) | - |
| `ImGui.BeginPopupModal` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L12) | - |
| `ImGui.EndPopup` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L33) | - |
| `ImGui.OpenPopup` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L38) | - |
| `ImGui.OpenPopupOnItemClick` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L47) | - |
| `ImGui.CloseCurrentPopup` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L61) | - |
| `ImGui.BeginPopupContextItem` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L66) | - |
| `ImGui.BeginPopupContextWindow` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L80) | - |
| `ImGui.BeginPopupContextVoid` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L94) | - |
| `ImGui.IsPopupOpen` | ✅ | [imgui_popup_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_popup_gm.cpp#L108) | - |
| `ImGui.BeginTable` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L3) | - |
| `ImGui.EndTable` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L19) | - |
| `ImGui.TableNextRow` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L24) | - |
| `ImGui.TableNextColumn` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L34) | - |
| `ImGui.TableSetColumnIndex` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L39) | - |
| `ImGui.TableSetupColumn` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L46) | - |
| `ImGui.TableSetupScrollFreeze` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L59) | - |
| `ImGui.TableHeader` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L77) | - |
| `ImGui.TableHeadersRow` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L67) | - |
| `ImGui.TableAngledHeadersRow` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L72) | - |
| `ImGui.TableGetSortSpecs` | ❌ | - | - |
| `ImGui.TableGetColumnCount` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L89) | - |
| `ImGui.TableGetColumnIndex` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L94) | - |
| `ImGui.TableGetRowIndex` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L116) | - |
| `ImGui.TableGetColumnName` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L99) | - |
| `ImGui.TableGetColumnFlags` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L108) | - |
| `ImGui.TableSetColumnEnabled` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L121) | - |
| `ImGui.TableGetHoveredColumn` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L84) | - |
| `ImGui.TableSetBgColor` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L129) | - |
| `ImGui.Columns` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L140) | - |
| `ImGui.NextColumn` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L152) | - |
| `ImGui.GetColumnIndex` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L157) | - |
| `ImGui.GetColumnWidth` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L162) | - |
| `ImGui.SetColumnWidth` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L170) | - |
| `ImGui.GetColumnOffset` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L178) | - |
| `ImGui.SetColumnOffset` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L186) | - |
| `ImGui.GetColumnsCount` | ✅ | [imgui_table_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_table_gm.cpp#L194) | - |
| `ImGui.BeginTabBar` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L3) | - |
| `ImGui.EndTabBar` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L12) | - |
| `ImGui.BeginTabItem` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L17) | - |
| `ImGui.EndTabItem` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L38) | - |
| `ImGui.TabItemButton` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L43) | - |
| `ImGui.SetTabItemClosed` | ✅ | [imgui_tabs_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_tabs_gm.cpp#L52) | - |
| `ImGui.DockSpace` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L6) | - |
| `ImGui.DockSpaceOverViewport` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L47) | - |
| `ImGui.SetNextWindowDockID` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L76) | - |
| `ImGui.SetNextWindowClass` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L87) | - |
| `ImGui.GetWindowDockID` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L101) | - |
| `ImGui.IsWindowDocked` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L107) | - |
| `ImGui.LogToTTY` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L550) | - |
| `ImGui.LogToFile` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L569) | - |
| `ImGui.LogToClipboard` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L542) | - |
| `ImGui.LogFinish` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L559) | - |
| `ImGui.LogButtons` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L564) | - |
| `ImGui.LogText` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L535) | - |
| `ImGui.LogTextV` | ❌ | - | - |
| `ImGui.BeginDragDropSource` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L3) | - |
| `ImGui.SetDragDropPayload` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L26) | - |
| `ImGui.EndDragDropSource` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L11) | - |
| `ImGui.BeginDragDropTarget` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L16) | - |
| `ImGui.AcceptDragDropPayload` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L59) | - |
| `ImGui.EndDragDropTarget` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L21) | - |
| `ImGui.GetDragDropPayload` | ✅ | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L73) | - |
| `ImGui.BeginDisabled` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L185) | - |
| `ImGui.EndDisabled` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L193) | - |
| `ImGui.PushClipRect` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L258) | - |
| `ImGui.PopClipRect` | ✅ | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L269) | - |
| `ImGui.SetItemDefaultFocus` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L409) | - |
| `ImGui.SetKeyboardFocusHere` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L389) | - |
| `ImGui.SetNavCursorVisible` | ❌ | - | - |
| `ImGui.SetNextItemAllowOverlap` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L317) | - |
| `ImGui.IsItemHovered` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L198) | - |
| `ImGui.IsItemActive` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L206) | - |
| `ImGui.IsItemFocused` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L211) | - |
| `ImGui.IsItemClicked` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L216) | - |
| `ImGui.IsItemVisible` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L224) | - |
| `ImGui.IsItemEdited` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L229) | - |
| `ImGui.IsItemActivated` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L234) | - |
| `ImGui.IsItemDeactivated` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L239) | - |
| `ImGui.IsItemDeactivatedAfterEdit` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L244) | - |
| `ImGui.IsItemToggledOpen` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L249) | - |
| `ImGui.IsAnyItemHovered` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L254) | - |
| `ImGui.IsAnyItemActive` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L259) | - |
| `ImGui.IsAnyItemFocused` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L264) | - |
| `ImGui.GetItemID` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L269) | - |
| `ImGui.GetItemRectMin` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetItemRectMax` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetItemRectSize` | ✅ | - | Supported with suffix (Width, Height) |
| `ImGui.GetMainViewport` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L519) | - |
| `ImGui.GetBackgroundDrawList` | ✅ | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L4) | - |
| `ImGui.GetForegroundDrawList` | ✅ | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L18) | - |
| `ImGui.IsRectVisible` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L333) | - |
| `ImGui.GetTime` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L343) | - |
| `ImGui.GetFrameCount` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L348) | - |
| `ImGui.GetDrawListSharedData` | ❌ | - | - |
| `ImGui.GetStyleColorName` | ✅ | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L86) | - |
| `ImGui.SetStateStorage` | ❌ | - | - |
| `ImGui.GetStateStorage` | ❌ | - | - |
| `ImGui.CalcTextSize` | ✅ | - | Use `ImGui.CalcTextWidth` or `ImGui.CalcTextHeight` |
| `ImGui.ColorConvertU32ToFloat4` | ❌ | - | - |
| `ImGui.ColorConvertFloat4ToU32` | ❌ | - | - |
| `ImGui.ColorConvertRGBtoHSV` | ❌ | - | - |
| `ImGui.ColorConvertHSVtoRGB` | ❌ | - | - |
| `ImGui.IsKeyDown` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L3) | - |
| `ImGui.IsKeyPressed` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L20) | - |
| `ImGui.IsKeyReleased` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L39) | - |
| `ImGui.IsKeyChordPressed` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L58) | - |
| `ImGui.GetKeyPressedAmount` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L84) | - |
| `ImGui.GetKeyName` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L98) | - |
| `ImGui.SetNextFrameWantCaptureKeyboard` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L583) | - |
| `ImGui.Shortcut` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L305) | - |
| `ImGui.SetNextItemShortcut` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L325) | - |
| `ImGui.SetItemKeyOwner` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L337) | - |
| `ImGui.IsMouseDown` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L116) | - |
| `ImGui.IsMouseClicked` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L134) | - |
| `ImGui.IsMouseReleased` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L155) | - |
| `ImGui.IsMouseDoubleClicked` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L173) | - |
| `ImGui.IsMouseReleasedWithDelay` | ❌ | - | - |
| `ImGui.GetMouseClickedCount` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L191) | - |
| `ImGui.IsMouseHoveringRect` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L202) | - |
| `ImGui.IsMousePosValid` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L215) | - |
| `ImGui.IsAnyMouseDown` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L222) | - |
| `ImGui.GetMousePos` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetMousePosOnOpeningCurrentPopup` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.IsMouseDragging` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L227) | - |
| `ImGui.GetMouseDragDelta` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.ResetMouseDragDelta` | ✅ | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L295) | - |
| `ImGui.GetMouseCursor` | ✅ | - | Supported internally |
| `ImGui.SetMouseCursor` | ❌ | - | - |
| `ImGui.SetNextFrameWantCaptureMouse` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L596) | - |
| `ImGui.GetClipboardText` | ❌ | - | - |
| `ImGui.SetClipboardText` | ❌ | - | - |
| `ImGui.LoadIniSettingsFromDisk` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L453) | - |
| `ImGui.LoadIniSettingsFromMemory` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L464) | - |
| `ImGui.SaveIniSettingsToDisk` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L476) | - |
| `ImGui.SaveIniSettingsToMemory` | ✅ | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L488) | - |
| `ImGui.DebugTextEncoding` | ❌ | - | - |
| `ImGui.DebugFlashStyleColor` | ❌ | - | - |
| `ImGui.DebugStartItemPicker` | ❌ | - | - |
| `ImGui.DebugCheckVersionAndDataLayout` | ❌ | - | - |
| `ImGui.DebugLog` | ❌ | - | - |
| `ImGui.DebugLogV` | ❌ | - | - |
| `ImGui.SetAllocatorFunctions` | ❌ | - | - |
| `ImGui.GetAllocatorFunctions` | ❌ | - | - |
| `ImGui.MemAlloc` | ❌ | - | - |
| `ImGui.MemFree` | ❌ | - | - |
| `ImGui.UpdatePlatformWindows` | ✅ | - | Supported internally |
| `ImGui.RenderPlatformWindowsDefault` | ❌ | - | - |
| `ImGui.DestroyPlatformWindows` | ✅ | - | Supported internally |
| `ImGui.FindViewportByID` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L29) | - |
| `ImGui.FindViewportByPlatformHandle` | ✅ | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L38) | - |
| `ImGui.SetWindowFontScale` | ✅ | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L127) | - |
| `ImGui.GetContentRegionMax` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetWindowContentRegionMin` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.GetWindowContentRegionMax` | ✅ | - | Supported with suffix (X, Y) |
| `ImGui.SetItemAllowOverlap` | ❌ | - | - |


## Custom Wrappers

These are non-standard functions made specifically for ImGui.

| Wrapper | Wrapper Location | Note |
|---------|------------------|------|
| `ImGui.AddFontDefault` | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L76) | - |
| `ImGui.AddFontFromFileTTF` | [imgui_fonts_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_fonts_gm.cpp#L37) | - |
| `ImGui.BeginChildFrame` | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L49) | - |
| `ImGui.CalcTextHeight` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L365) | - |
| `ImGui.CalcTextWidth` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L353) | - |
| `ImGui.ClearIniSettings` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L496) | - |
| `ImGui.ConfigFlagsGet` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L414) | - |
| `ImGui.ConfigFlagsSet` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L501) | - |
| `ImGui.ConfigFlagToggle` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L509) | - |
| `ImGui.DockBuilderAddNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L137) | - |
| `ImGui.DockBuilderCopyDockSpace` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L202) | - |
| `ImGui.DockBuilderCopyNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L221) | - |
| `ImGui.DockBuilderCopyWindowSettings` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L239) | - |
| `ImGui.DockBuilderDockWindow` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L115) | - |
| `ImGui.DockBuilderFinish` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L247) | - |
| `ImGui.DockBuilderGetCentralNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L130) | - |
| `ImGui.DockBuilderGetNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L123) | - |
| `ImGui.DockBuilderRemoveNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L147) | - |
| `ImGui.DockBuilderRemoveNodeChildNodes` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L163) | - |
| `ImGui.DockBuilderRemoveNodeDockedWindows` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L154) | - |
| `ImGui.DockBuilderSetNodePos` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L170) | - |
| `ImGui.DockBuilderSetNodeSize` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L179) | - |
| `ImGui.DockBuilderSplitNode` | [imgui_docking_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_docking_gm.cpp#L188) | - |
| `ImGui.DragFloatN` | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L94) | - |
| `ImGui.DragIntN` | [imgui_drag_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drag_gm.cpp#L237) | - |
| `ImGui.Draw` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L197) | - |
| `ImGui.DrawListAddBezierCubic` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L309) | - |
| `ImGui.DrawListAddBezierQuadratic` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L329) | - |
| `ImGui.DrawListAddCircle` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L172) | - |
| `ImGui.DrawListAddCircleFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L188) | - |
| `ImGui.DrawListAddConvexPolyFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L287) | - |
| `ImGui.DrawListAddImage` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L471) | - |
| `ImGui.DrawListAddImageRounded` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L494) | - |
| `ImGui.DrawListAddLine` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L37) | - |
| `ImGui.DrawListAddNgon` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L202) | - |
| `ImGui.DrawListAddNgonFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L218) | - |
| `ImGui.DrawListAddPolyline` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L261) | - |
| `ImGui.DrawListAddQuad` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L104) | - |
| `ImGui.DrawListAddQuadFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L123) | - |
| `ImGui.DrawListAddRect` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L52) | - |
| `ImGui.DrawListAddRectFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L71) | - |
| `ImGui.DrawListAddRectFilledMultiColor` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L88) | - |
| `ImGui.DrawListAddText` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L232) | - |
| `ImGui.DrawListAddTextFont` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L244) | - |
| `ImGui.DrawListAddTriangle` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L140) | - |
| `ImGui.DrawListAddTriangleFilled` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L157) | - |
| `ImGui.DrawListFlagsGet` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L563) | - |
| `ImGui.DrawListFlagsSet` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L571) | - |
| `ImGui.DrawListFlagToggle` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L580) | - |
| `ImGui.DrawListPathArcTo` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L397) | - |
| `ImGui.DrawListPathArcToFast` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L412) | - |
| `ImGui.DrawListPathBezierCubicCurveTo` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L425) | - |
| `ImGui.DrawListPathBezierQuadraticCurveTo` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L441) | - |
| `ImGui.DrawListPathClear` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L369) | - |
| `ImGui.DrawListPathFillConvex` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L347) | - |
| `ImGui.DrawListPathLineTo` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L377) | - |
| `ImGui.DrawListPathLineToMergeDuplicate` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L387) | - |
| `ImGui.DrawListPathRect` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L455) | - |
| `ImGui.DrawListPathStroke` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L356) | - |
| `ImGui.DrawListPopClipRect` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L536) | - |
| `ImGui.DrawListPopTextureID` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L555) | - |
| `ImGui.DrawListPushClipRect` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L516) | - |
| `ImGui.DrawlistPushClipRectFullscreen` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L529) | - |
| `ImGui.DrawListPushTextureID` | [imgui_drawlist_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_drawlist_gm.cpp#L544) | - |
| `ImGui.EndChildFrame` | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L62) | - |
| `ImGui.GetContentRegionAvailX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L165) | - |
| `ImGui.GetContentRegionAvailY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L172) | - |
| `ImGui.GetContentRegionMaxX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L179) | - |
| `ImGui.GetContentRegionMaxY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L186) | - |
| `ImGui.GetCursorScreenPosX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L101) | - |
| `ImGui.GetCursorScreenPosY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L108) | - |
| `ImGui.GetCursorStartPosX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L87) | - |
| `ImGui.GetCursorStartPosY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L94) | - |
| `ImGui.GetDragDropPayloadType` | [imgui_payload_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_payload_gm.cpp#L83) | - |
| `ImGui.GetItemRectMaxX` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L289) | - |
| `ImGui.GetItemRectMaxY` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L296) | - |
| `ImGui.GetItemRectMinX` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L275) | - |
| `ImGui.GetItemRectMinY` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L282) | - |
| `ImGui.GetItemRectSizeHeight` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L310) | - |
| `ImGui.GetItemRectSizeWidth` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L303) | - |
| `ImGui.GetKeyChordName` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L107) | - |
| `ImGui.GetMouseDragDeltaX` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L268) | - |
| `ImGui.GetMouseDragDeltaY` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L281) | - |
| `ImGui.GetMousePosOnOpeningCurrentPopupX` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L254) | - |
| `ImGui.GetMousePosOnOpeningCurrentPopupY` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L261) | - |
| `ImGui.GetMousePosX` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L240) | - |
| `ImGui.GetMousePosY` | [imgui_input_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_gm.cpp#L247) | - |
| `ImGui.GetStyleColor` | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L79) | - |
| `ImGui.GetViewportID` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L524) | - |
| `ImGui.GetWindowContentRegionMaxX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L207) | - |
| `ImGui.GetWindowContentRegionMaxY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L214) | - |
| `ImGui.GetWindowContentRegionMinX` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L193) | - |
| `ImGui.GetWindowContentRegionMinY` | [imgui_layout_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_layout_gm.cpp#L200) | - |
| `ImGui.GetWindowPosX` | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L98) | - |
| `ImGui.GetWindowPosY` | [imgui_window_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_window_gm.cpp#L105) | - |
| `ImGui.IniFilename` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L422) | - |
| `ImGui.Initialize` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L6) | - |
| `ImGui.Input` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L241) | - |
| `ImGui.InputFloatN` | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L130) | - |
| `ImGui.InputIntN` | [imgui_input_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_input_widgets_gm.cpp#L218) | - |
| `ImGui.Key` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L234) | - |
| `ImGui.MemoryEditorDrawContents` | [imgui_ext_memeditor_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_ext_memeditor_gm.cpp#L18) | - |
| `ImGui.MemoryEditorShowWindow` | [imgui_ext_memeditor_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_ext_memeditor_gm.cpp#L5) | - |
| `ImGui.Mouse` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L252) | - |
| `ImGui.MouseCursor` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L266) | - |
| `ImGui.MouseWheel` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L259) | - |
| `ImGui.PopAllowKeyboardFocus` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L384) | - |
| `ImGui.PopButtonRepeat` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L404) | - |
| `ImGui.PushAllowKeyboardFocus` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L377) | - |
| `ImGui.PushButtonRepeat` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L397) | - |
| `ImGui.SelectionStorageApplyRequests` | [imgui_selectable_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_selectable_gm.cpp#L58) | - |
| `ImGui.SetStyleColor` | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L94) | - |
| `ImGui.SetStyleVar` | [imgui_style_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_style_gm.cpp#L107) | - |
| `ImGui.Shutdown` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L102) | - |
| `ImGui.SliderFloatN` | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L86) | - |
| `ImGui.SliderIntN` | [imgui_slider_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_slider_gm.cpp#L196) | - |
| `ImGui.Surface` | [imgui_widgets_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_widgets_gm.cpp#L88) | - |
| `ImGui.UpdateStateFromStruct` | [imgui_main_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_main_gm.cpp#L132) | - |
| `ImGui.WantKeyboardCapture` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L609) | - |
| `ImGui.WantMouseCapture` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L624) | - |
| `ImGui.WantMouseCaptureUnlessPopupClose` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L654) | - |
| `ImGui.WantSaveIniSettings` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L437) | - |
| `ImGui.WantTextInput` | [imgui_api_gm.cpp](https://github.com/knno/ImGM/blob/main/src/dll/imgui/wrappers/imgui_api_gm.cpp#L639) | - |