cmake_minimum_required(VERSION 3.16.0 FATAL_ERROR)

project(dll CXX)

################################################################################
# Set target arch type if empty. Visual studio solution generator provides it.
################################################################################
if(NOT CMAKE_VS_PLATFORM_NAME)
    set(CMAKE_VS_PLATFORM_NAME "x64")
endif()
message("${CMAKE_VS_PLATFORM_NAME} architecture in use")

if(NOT ("${CMAKE_VS_PLATFORM_NAME}" STREQUAL "x64"))
    message(FATAL_ERROR "${CMAKE_VS_PLATFORM_NAME} arch is not supported!")
endif()

################################################################################
# Global configuration types
################################################################################
set(CMAKE_CONFIGURATION_TYPES
    "Debug"
    "Release"
    CACHE STRING "" FORCE
)

################################################################################
# Global compiler options
################################################################################
if(MSVC)
    # remove default flags provided with CMake for MSVC
    set(CMAKE_CXX_FLAGS "")
    set(CMAKE_CXX_FLAGS_DEBUG "")
    set(CMAKE_CXX_FLAGS_RELEASE "")
endif()

################################################################################
# Global linker options
################################################################################
if(MSVC)
    # remove default flags provided with CMake for MSVC
    set(CMAKE_EXE_LINKER_FLAGS "")
    set(CMAKE_MODULE_LINKER_FLAGS "")
    set(CMAKE_SHARED_LINKER_FLAGS "")
    set(CMAKE_STATIC_LINKER_FLAGS "")
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS}")
    set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS}")
    set(CMAKE_STATIC_LINKER_FLAGS_DEBUG "${CMAKE_STATIC_LINKER_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS}")
    set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "${CMAKE_MODULE_LINKER_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS}")
    set(CMAKE_STATIC_LINKER_FLAGS_RELEASE "${CMAKE_STATIC_LINKER_FLAGS}")
endif()

################################################################################
# Nuget packages function stub.
################################################################################
function(use_package TARGET PACKAGE VERSION)
    message(WARNING "No implementation of use_package. Create yours. "
                    "Package \"${PACKAGE}\" with version \"${VERSION}\" "
                    "for target \"${TARGET}\" is ignored!")
endfunction()

################################################################################
# Common utils
################################################################################
include(CMake/Utils.cmake)

################################################################################
# Additional Global Settings(add specific info there)
################################################################################
include(CMake/GlobalSettingsInclude.cmake OPTIONAL)

################################################################################
# Use solution folders feature
################################################################################
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

################################################################################
# Sub-projects
################################################################################



























set(PROJECT_NAME ImGMDll)

################################################################################
# Source groups
################################################################################
set(no_group_source_files
    "imgm.cpp"
    "imgm.h"
)
source_group("" FILES ${no_group_source_files})

set(Config
    "config.h"
    "internal/gm.h"
)
source_group("Config" FILES ${Config})

set(ImGui
    "imgui/imgui_impl_gm.cpp"
    "imgui/imgui_impl_gm.h"
)
source_group("ImGui" FILES ${ImGui})

set(ImGui__Internal
    "imgui/internal/backends/imgui_impl_dx11.cpp"
    "imgui/internal/backends/imgui_impl_dx11.h"
    "imgui/internal/backends/imgui_impl_win32.cpp"
    "imgui/internal/backends/imgui_impl_win32.h"
    "imgui/internal/imconfig.h"
    "imgui/internal/imgui.cpp"
    "imgui/internal/imgui.h"
    "imgui/internal/imgui_demo.cpp"
    "imgui/internal/imgui_draw.cpp"
    "imgui/internal/imgui_internal.h"
    "imgui/internal/imgui_tables.cpp"
    "imgui/internal/imgui_widgets.cpp"
    "imgui/internal/imstb_rectpack.h"
    "imgui/internal/imstb_textedit.h"
    "imgui/internal/imstb_truetype.h"
)
source_group("ImGui\\Internal" FILES ${ImGui__Internal})

set(ImGui__wrappers
    "imgui/wrappers/imgui_api_gm.cpp"
    "imgui/wrappers/imgui_color_gm.cpp"
    "imgui/wrappers/imgui_combo_gm.cpp"
    "imgui/wrappers/imgui_docking_gm.cpp"
    "imgui/wrappers/imgui_drag_gm.cpp"
    "imgui/wrappers/imgui_drawlist_gm.cpp"
    "imgui/wrappers/imgui_ext_memeditor_gm.cpp"
    "imgui/wrappers/imgui_fonts_gm.cpp"
    "imgui/wrappers/imgui_gm_selectionstorage.h"
    "imgui/wrappers/imgui_gm_windowclass.h"
    "imgui/wrappers/imgui_input_gm.cpp"
    "imgui/wrappers/imgui_input_widgets_gm.cpp"
    "imgui/wrappers/imgui_layout_gm.cpp"
    "imgui/wrappers/imgui_listbox_gm.cpp"
    "imgui/wrappers/imgui_memory_editor.h"
    "imgui/wrappers/imgui_menu_gm.cpp"
    "imgui/wrappers/imgui_payload_gm.cpp"
    "imgui/wrappers/imgui_plots_gm.cpp"
    "imgui/wrappers/imgui_popup_gm.cpp"
    "imgui/wrappers/imgui_selectable_gm.cpp"
    "imgui/wrappers/imgui_slider_gm.cpp"
    "imgui/wrappers/imgui_style_gm.cpp"
    "imgui/wrappers/imgui_table_gm.cpp"
    "imgui/wrappers/imgui_tabs_gm.cpp"
    "imgui/wrappers/imgui_text_gm.cpp"
    "imgui/wrappers/imgui_tooltips_gm.cpp"
    "imgui/wrappers/imgui_tree_gm.cpp"
    "imgui/wrappers/imgui_widgets_gm.cpp"
    "imgui/wrappers/imgui_window_gm.cpp"
)
source_group("ImGui\\wrappers" FILES ${ImGui__wrappers})

set(ALL_FILES
    ${no_group_source_files}
    ${Config}
    ${ImGui}
    ${ImGui__Internal}
    ${ImGui__wrappers}
)

################################################################################
# Target
################################################################################
add_library(${PROJECT_NAME} SHARED ${ALL_FILES})

use_props(${PROJECT_NAME} "${CMAKE_CONFIGURATION_TYPES}" "${DEFAULT_CXX_PROPS}")
set(ROOT_NAMESPACE ImGM)

set_target_properties(${PROJECT_NAME} PROPERTIES
    VS_GLOBAL_KEYWORD "Win32Proj"
)
################################################################################
# Target name
################################################################################
set_target_properties(${PROJECT_NAME} PROPERTIES
    TARGET_NAME_DEBUG   "ImGM"
    TARGET_NAME_RELEASE "ImGM"
)
################################################################################
# Output directory
################################################################################
set_target_properties(${PROJECT_NAME} PROPERTIES
    OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/../gm/ImGM/extensions/ImGM/"
    OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/../gm/ImGM/extensions/ImGM/"
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_CURRENT_SOURCE_DIR}/../gm/ImGM/extensions/ImGM"
    ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/../gm/ImGM/extensions/ImGM"
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    ARCHIVE_OUTPUT_NAME_DEBUG   "ImGM"
    ARCHIVE_OUTPUT_NAME_RELEASE "ImGM"
)
################################################################################
# Include directories
################################################################################
target_include_directories(${PROJECT_NAME} PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/.;"
    "${CMAKE_CURRENT_SOURCE_DIR}/internal;"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui;"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui/internal"
)

################################################################################
# Compile definitions
################################################################################
target_compile_definitions(${PROJECT_NAME} PRIVATE
    "$<$<CONFIG:Debug>:"
        "DEBUG"
    ">"
    "$<$<CONFIG:Release>:"
        "NDEBUG"
    ">"
    "GDKEXTENSION_EXPORTS;"
    "__YYDEFINE_EXTENSION_FUNCTIONS__;"
    "OS_Windows;"
    "UNICODE;"
    "_UNICODE"
)

################################################################################
# Compile and link options
################################################################################
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Debug>:
            /Od;
            /ZI
        >
        $<$<CONFIG:Release>:
            /Gm-;
            /Ox;
            /Oi;
            /GF;
            /Gy;
            ${DEFAULT_CXX_DEBUG_INFORMATION_FORMAT}
        >
        /std:c++14;
        /W3;
        ${DEFAULT_CXX_EXCEPTION_HANDLING};
        /Y-
    )
    target_link_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Debug>:
            /DEBUG;
            /INCREMENTAL
        >
        $<$<CONFIG:Release>:
            /DEBUG:FULL;
            /OPT:REF;
            /OPT:ICF;
            /INCREMENTAL:NO
        >
        /SUBSYSTEM:WINDOWS
    )
endif()

