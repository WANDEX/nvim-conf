-- AUTHOR: 'WANDEX/nvim-conf'
-- platform specific code

local ufn = require 'user.lib.fn'

local M = {
  os = {}, -- Operating System
  ws = {}, --    Window System/Server
}

---@nodiscard
---@return string
function M.os.platform()
  local uname = vim.uv.os_uname()
  local sysname = uname.sysname
  if sysname == "Darwin" then
    return "macos"
  elseif sysname == "Linux" then
    if uname.release:find("Microsoft") then
      return "wsl"
    else
      return "linux"
    end
  elseif sysname:match("Windows") then
    return "windows"
  else
    return sysname:lower()
  end
end

---@nodiscard
---@return string
function M.term()
  local term = os.getenv("TERM_PROGRAM") or os.getenv("TERM") or "unknown"
  return term:lower()
end

---@nodiscard
---@return boolean
function M.ws.is_wayland()
  -- WAYLAND_DISPLAY is usually set in Wayland sessions.
  -- WAYLAND_DISPLAY is an environment variable set by Wayland compositors.
  return os.getenv("WAYLAND_DISPLAY") ~= nil
end

---@nodiscard
---@return boolean
function M.ws.is_xorg()
  -- DISPLAY is usually set in X11 sessions.
  -- WAYLAND_DISPLAY normally is not set simultaneously.
  return not M.ws.is_wayland() and os.getenv("DISPLAY") ~= nil
end

---@nodiscard
---@return string
function M.ws.get_win_title_wayland() -- TODO
  vim.notify("get_win_title_wayland(): UNIMPLEMENTED", vim.log.levels.WARN)
  return ""
end

---@nodiscard
---@return string
function M.ws.get_win_title_xorg()
  local ok_id, win_id = pcall(vim.fn.system, { 'xdotool', 'getactivewindow' })
  if not ok_id then
    return ""
  end
  local ok_name, win_wm_name = pcall(vim.fn.system, { 'xprop', '-id', win_id, 'WM_NAME' })
  if not ok_name then
    return ""
  end
  return ufn.split_by(win_wm_name, ' = "')[2]
end

---@nodiscard
---@return string
function M.get_win_title()
  local os = M.os.platform()
  if os == "linux" then
    if M.ws.is_wayland() then
      return M.ws.get_win_title_wayland()
    elseif M.ws.is_xorg() then
      return M.ws.get_win_title_xorg()
    else
      vim.notify("get_win_title(): Unknown or non-graphical session", vim.log.levels.WARN)
    end
  else
    vim.notify("get_win_title(): UNIMPLEMENTED for the platform", vim.log.levels.WARN)
  end
  return ""
end

return M
