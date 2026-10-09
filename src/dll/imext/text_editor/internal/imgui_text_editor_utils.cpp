/// This file is originally written by TrashBash <github.com/TrashBash>

#include "../../imgm.h"
#include <imgui_text_editor.h>

#include <unordered_map>
#include <vector>
#include <string>

// Use a static map to store instances
static std::unordered_map<int32_t, TextEditor*> EDITORS;

// Stores IDs of destroyed editors
static std::vector<int32_t> FREE_IDS;
static int32_t NEXT_ID = 0;

static inline TextEditor* __editor_get(int32_t _handle) {
	auto _entry = EDITORS.find(_handle);
	return (_entry == EDITORS.end()) ? nullptr : _entry->second;
}

#define CHECK_EDITOR_BOOL \
	auto* _editor = __editor_get(_handle); \
	if (!_editor) \
		__return_bool(Result, false);

#define CHECK_EDITOR_STRING \
	auto* _editor = __editor_get(_handle); \
	if (!_editor) \
		__return_string(Result, "");


// @ COLOR HELPER
static inline int32_t IMU32_TO_GML_RGB(ImU32 _color)
{
	int32_t R = (_color & 0xFF);
	int32_t G = ((_color >> 8) & 0xFF);
	int32_t B = ((_color >> 16) & 0xFF);

	return (B << 16) | (G << 8) | R;
}

// @ RETURN HELPER
static inline void __return_i32(RValue& Result, int32_t _value)
{
	Result.kind = VALUE_INT32;
	Result.v32	= _value;
	return;
}

static inline void __return_i64(RValue& Result, int64_t _value)
{
	Result.kind = VALUE_INT64;
	Result.v64	= _value;
	return;
}

static inline void __return_bool(RValue& Result, bool _value)
{
	Result.kind = VALUE_BOOL;
	Result.val	= _value;
	return;
}

static inline void __return_undefined(RValue& Result)
{
	Result.kind = VALUE_UNDEFINED;
	return;
}

static inline void __return_string(RValue& Result, const std::string& _string)
{
	Result.kind = VALUE_STRING;
	YYCreateString(&Result, _string.c_str());
	return;
}
