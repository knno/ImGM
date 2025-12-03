#pragma warning(disable: 4244)

#include <tchar.h>
#include <stdlib.h>
#include <string>
#include <imgui_impl_gm.h>
#include <imgm.h>

bool g_ImGuiInitialized;

char g_InputBuf[INPUT_SIZE];
RValue g_Copy;

ID3D11Device* g_pd3dDevice;
ID3D11DeviceContext* g_pd3dDeviceContext;
ID3D11ShaderResourceView* g_pView;

ImGuiGFlags g_ImGuiGFlags;
int g_KeepAlive;

YYRunnerInterface gs_runnerInterface;
YYRunnerInterface* g_pYYRunnerInterface;

GMEXPORT void YYExtensionInitialise(const struct YYRunnerInterface* _pFunctions, size_t _functions_size) {
	if (_functions_size < sizeof(YYRunnerInterface)) {
		memcpy(&gs_runnerInterface, _pFunctions, _functions_size);
	} else {
		memcpy(&gs_runnerInterface, _pFunctions, sizeof(YYRunnerInterface));
	}
	g_pYYRunnerInterface = &gs_runnerInterface;

	WriteLog("Successfully initialized runner interface");
	return;
}
