#pragma once
#include "../imgm.h"
#include "../internal/ImFileDialog.h"

bool g_fileDialogUseGMTextures = false;
void* g_fileDialogFolderTexture = nullptr;
void* g_fileDialogFileTexture = nullptr;
void* g_fileDialogQuickAccessTexture = nullptr;

/**
 * @desc Initializes ImFileDialog and textures for rendering.
 */
GMFUNC(__imext_file_dialog_setup) {
    GMOVERRIDE(Setup)

    bool is_gm_mode = YYGetBool(arg, 0);
    GMDEFAULT(undefined)
    double icon_folder_sprite = YYGetReal(arg, 1);
    GMDEFAULT(undefined)
    double icon_folder_sprite_image_index = YYGetReal(arg, 2);
    GMDEFAULT(0)
    double icon_file_sprite = YYGetReal(arg, 3);
    GMDEFAULT(undefined)
    double icon_file_sprite_image_index = YYGetReal(arg, 4);
    GMDEFAULT(0)
    double icon_quick_access_sprite = YYGetReal(arg, 5);
    GMDEFAULT(undefined)
    double icon_quick_access_sprite_image_index = YYGetReal(arg, 6);
    GMDEFAULT(0)
    g_fileDialogUseGMTextures = is_gm_mode;
    g_fileDialogFolderTexture = (void*)GetTexture(icon_folder_sprite, icon_folder_sprite_image_index, TextureType_Sprite);
    g_fileDialogFileTexture = (void*)GetTexture(icon_file_sprite, icon_file_sprite_image_index, TextureType_Sprite);
    g_fileDialogQuickAccessTexture = (void*)GetTexture(icon_quick_access_sprite, icon_quick_access_sprite_image_index, TextureType_Sprite);

    if (is_gm_mode && false) {
        ifd::FileDialog::Instance().CreateTexture = [](uint8_t*, int, int, char) -> void* { return nullptr; };
        ifd::FileDialog::Instance().DeleteTexture = [](void*) {};
    } else {
        ifd::FileDialog::Instance().CreateTexture = [](uint8_t* data, int w, int h, char fmt) -> void* {
            if (!g_pd3dDevice) return nullptr;

            D3D11_TEXTURE2D_DESC desc;
            ZeroMemory(&desc, sizeof(desc));
            desc.Width = w;
            desc.Height = h;
            desc.MipLevels = 1;
            desc.ArraySize = 1;
            desc.Format = (fmt == 0) ? DXGI_FORMAT_B8G8R8A8_UNORM : DXGI_FORMAT_R8G8B8A8_UNORM;
            desc.SampleDesc.Count = 1;
            desc.Usage = D3D11_USAGE_DEFAULT;
            desc.BindFlags = D3D11_BIND_SHADER_RESOURCE;

            ID3D11Texture2D* pTexture = nullptr;
            D3D11_SUBRESOURCE_DATA subResource;
            subResource.pSysMem = data;
            subResource.SysMemPitch = w * 4;
            subResource.SysMemSlicePitch = 0;

            if (FAILED(g_pd3dDevice->CreateTexture2D(&desc, &subResource, &pTexture))) return nullptr;

            ID3D11ShaderResourceView* pSRV = nullptr;
            g_pd3dDevice->CreateShaderResourceView(pTexture, nullptr, &pSRV);
            pTexture->Release();

            return (void*)pSRV;
        };

        ifd::FileDialog::Instance().DeleteTexture = [](void* tex) {
            if (tex) static_cast<ID3D11ShaderResourceView*>(tex)->Release();
        };
    }
    Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Opens a file dialog.
 */
GMFUNC(__imext_file_dialog_open) {
    GMOVERRIDE(Open)

    const char* key = YYGetString(arg, 0);
    const char* title = YYGetString(arg, 1);
    const char* filter = YYGetString(arg, 2);
    bool is_multiselect = YYGetBool(arg, 3);
    const char* starting_dir = YYGetString(arg, 4);

    ifd::FileDialog::Instance().Open(key, title, filter, is_multiselect, starting_dir);
    Result.kind = VALUE_UNDEFINED;
}


/**
 * @desc Opens a save file dialog.
 */
GMFUNC(__imext_file_dialog_save) {
  GMOVERRIDE(Save)
  const char* key = YYGetString(arg, 0);
  const char* title = YYGetString(arg, 1);
  const char* filter = YYGetString(arg, 2);
  const char* starting_dir = YYGetString(arg, 3);
  const char* starting_file = YYGetString(arg, 4);

  ifd::FileDialog::Instance().Save(key, title, filter, starting_dir,
                                   starting_file);
  Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns whether the dialog has finished (user confirmed or canceled).
 */
GMFUNC(__imext_file_dialog_is_done) {
  GMOVERRIDE(IsDone)
  const char* key = YYGetString(arg, 0);
  Result.kind = VALUE_BOOL;
  Result.val = ifd::FileDialog::Instance().IsDone(key);
}

/**
 * @desc Returns whether the dialog finished with a successful result.
 */
GMFUNC(__imext_file_dialog_has_result) {
  GMOVERRIDE(HasResult)
  Result.kind = VALUE_BOOL;
  Result.val = ifd::FileDialog::Instance().HasResult();
}

/**
 * @desc Returns the file path result as a string.
 */
GMFUNC(__imext_file_dialog_get_result) {
  GMOVERRIDE(GetResult)
  Result.kind = VALUE_STRING;
  // ImFileDialog returns std::filesystem::path, so we convert it to a C-string
  // for GameMaker
  YYCreateString(&Result,
                 ifd::FileDialog::Instance().GetResult().string().c_str());
}

/**
 * @desc Returns the number of files selected (if multiselect is enabled).
 */
GMFUNC(__imext_file_dialog_get_result_count) {
  GMOVERRIDE(GetResultCount)
  Result.kind = VALUE_REAL;
  Result.val =
      static_cast<double>(ifd::FileDialog::Instance()
                              .GetResults()
                              .size()); // ImFileDialog uses GetResults() vector
}

/**
 * @desc Returns the file path result at the given index (for multiselect).
 */
GMFUNC(__imext_file_dialog_get_result_index) {
  GMOVERRIDE(GetResultIndex)
  int index = static_cast<int>(YYGetReal(arg, 0));
  Result.kind = VALUE_STRING;

  // Safety check to prevent crashing if GameMaker passes an out-of-bounds index
  if (index >= 0 && index < ifd::FileDialog::Instance().GetResults().size()) {
    YYCreateString(
        &Result,
        ifd::FileDialog::Instance().GetResults()[index].string().c_str());
  } else {
    YYCreateString(&Result, "");
  }
}

/**
 * @desc Closes the current dialog.
 */
GMFUNC(__imext_file_dialog_close) {
  GMOVERRIDE(Close)
  ifd::FileDialog::Instance().Close();
  Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Sets the zoom factor for the file dialog icons/thumbnails.
 */
GMFUNC(__imext_file_dialog_set_zoom) {
  GMOVERRIDE(SetZoom)
  float zoom = static_cast<float>(YYGetReal(arg, 0));
  ifd::FileDialog::Instance().SetZoom(zoom);
  Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the current zoom factor.
 */
GMFUNC(__imext_file_dialog_get_zoom) {
  GMOVERRIDE(GetZoom)
  Result.kind = VALUE_REAL;
  Result.val = static_cast<double>(ifd::FileDialog::Instance().GetZoom());
}

/**
 * @desc Adds a favorite folder shortcut to the side pane.
 */
GMFUNC(__imext_file_dialog_add_favorite) {
  GMOVERRIDE(AddFavorite)
  const char* path = YYGetString(arg, 0);
  ifd::FileDialog::Instance().AddFavorite(path);
  Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Removes a favorite folder shortcut.
 */
GMFUNC(__imext_file_dialog_remove_favorite) {
  GMOVERRIDE(RemoveFavorite)
  const char* path = YYGetString(arg, 0);
  ifd::FileDialog::Instance().RemoveFavorite(path);
  Result.kind = VALUE_UNDEFINED;
}

/**
 * @desc Returns the number of favorite folders.
 */
GMFUNC(__imext_file_dialog_get_favorites_count) {
    GMOVERRIDE(GetFavoritesCount)
    Result.kind = VALUE_REAL;
    Result.val = static_cast<double>(ifd::FileDialog::Instance().GetFavorites().size());
}

/**
 * @desc Returns a favorite folder path by index.
 * @param index The favorite index.
 */
GMFUNC(__imext_file_dialog_get_favorite) {
    GMOVERRIDE(GetFavorite)
    int index = static_cast<int>(YYGetReal(arg, 0));
    const auto& favs = ifd::FileDialog::Instance().GetFavorites();

    Result.kind = VALUE_STRING;
    if (index >= 0 && index < favs.size()) {
        YYCreateString(&Result, favs[index].c_str()); // Assuming std::string return
    } else {
        YYCreateString(&Result, "");
    }
}
