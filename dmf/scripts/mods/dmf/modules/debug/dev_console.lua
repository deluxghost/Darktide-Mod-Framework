---@class DMFMod
local dmf = get_mod("DMF")

-- Note(Siku): This file could definitely use the hooking system if we could figure out a way.
-- It would requires hooks to be pushed higher in the loading order, but then we lose hooks printing to console
-- Unless we find a way to store our logging messages in memory before the console is loaded.

-- Local backup of the ffi library
local _ffi = dmf:persistent_table("_ffi")
_ffi.initialized = _ffi.initialized or false
if not _ffi.initialized then
  _ffi = dmf.deepcopy(Mods.lua.ffi)
end

local _console_data = dmf:persistent_table("dev_console_data")
if not _console_data.enabled then _console_data.enabled = false end
if not _console_data.original_print then _console_data.original_print = print end

local _log_to_developer_console

-- ####################################################################################################################
-- ##### Local functions ##############################################################################################
-- ####################################################################################################################

local function log_and_console_print(...)
  CommandWindow.print(...)
  _console_data.original_print(...)
end

local function open_dev_console()

  if not _console_data.enabled then
    CommandWindow.open("Developer console")
    _console_data.enabled = true
  end

  print = log_and_console_print
end

local function close_dev_console()

  if _console_data.enabled then

    print = _console_data.original_print

    CommandWindow.close()

    -- CommandWindow won't close by itself, so it has to be closed through FFI
    if _ffi then
      dmf:pcall(function()
        if _ffi then
          _ffi.cdef([[
            void* FindWindowA(const char* lpClassName, const char* lpWindowName);
            int64_t SendMessageA(void* hWnd, unsigned int Msg, uint64_t wParam, int64_t lParam);
          ]])
          local WM_CLOSE = 0x10;
          local hwnd = _ffi.C.FindWindowA("ConsoleWindowClass", "Developer console")
          _ffi.C.SendMessageA(hwnd, WM_CLOSE, 0, 0)
        end
      end)

    -- Or manually closed by the user
    else
      dmf:warning(dmf:localize("dev_console_close_warning"))
    end

    _console_data.enabled = false
  end
end

-- ####################################################################################################################
-- ##### DMF internal functions and variables #########################################################################
-- ####################################################################################################################

dmf.developer_console_print = log_and_console_print

dmf.is_developer_console_logging_enabled = function()
  return _console_data.enabled and _log_to_developer_console
end

dmf.toggle_developer_console = function ()

  if dmf:get("developer_mode") then

    local show_console = not dmf:get("show_developer_console")
    dmf:set("show_developer_console", show_console)

    dmf.load_dev_console_settings()

    if show_console then
      dmf:echo(dmf:localize("dev_console_opened"))
    else
      dmf:echo(dmf:localize("dev_console_closed"))
    end
  end
end

dmf.load_dev_console_settings = function()

  _log_to_developer_console = dmf:get("log_to_developer_console") ~= false

  if dmf:get("developer_mode") and dmf:get("show_developer_console") then
    open_dev_console()
  else
    close_dev_console()
  end
end

-- ####################################################################################################################
-- ##### Script #######################################################################################################
-- ####################################################################################################################

dmf.load_dev_console_settings()
