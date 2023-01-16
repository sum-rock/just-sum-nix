local M = {}

local w = vim.w
local a = vim.api
local wo = vim.wo
local fn = vim.fn
local hl = a.nvim_set_hl
local au = a.nvim_create_autocmd
local timer = vim.loop.new_timer()

local DEFAULT_OPTIONS = {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
}

function _is_exempt_type()
  local buf_name = vim.api.nvim_buf_get_name(0) 
  if string.find(buf_name, "NvimTree") then
    return true
  elseif string.find(buf_name, "toggleterm") then 
    return true
  else
    return false
  end
end

function _win_enter()
  if not _is_exempt_type() then
    wo.cursorline = true
  end
end

function _win_leave()
  if not _is_exempt_type() then
    wo.cursorline = false
  end
end

function _cursor_change(options)
  if not _is_exempt_type() then
    if M.options.cursorline.number then
      wo.cursorline = false
    else
      wo.cursorlineopt = "number"
    end
    timer:start(
      M.options.cursorline.timeout,
      0,
      vim.schedule_wrap(function()
        if M.options.cursorline.number then
          wo.cursorline = true
        else
          wo.cursorlineopt = "both"
        end
      end)
    )
  end
end
  
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", DEFAULT_OPTIONS, options or {})

  if M.options.cursorline.enable then
    wo.cursorline = true
    au("WinEnter", { 
        callback = function()
          _win_enter() 
        end,
    })
    au("WinLeave", { 
      callback = function()
        _win_leave() 
      end,
    })
    au({ "CursorMoved", "CursorMovedI" }, { 
      callback = function()
        _cursor_change(options) 
      end,
    })
  end
end

M.options = nil

return M
