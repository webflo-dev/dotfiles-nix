local M = {}

function M.load_modules(path, exclude, callback)
  exclude = vim.tbl_extend("force", { "init" }, exclude or {})

  local lua_path = table.concat({ vim.fn.stdpath("config"), "lua" }, "/")

  local glob = table.concat({
    lua_path,
    path:gsub("%.", "/"),
    "*.lua",
  }, "/")

  for _, file in ipairs(vim.fn.glob(glob, true, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if not vim.tbl_contains(exclude, name) then
      local module = require(path .. "." .. name)
      if callback ~= nil then
        callback(module, name, file)
      end
    end
  end
end

function M.load_specs(path, exclude)
  local specs = {}
  M.load_modules(path, exclude, function(module)
    table.insert(specs, module)
  end)
  return specs
end

local terminals = {}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    ft = "lazyterm",
    size = { width = 0.9, height = 0.9 },
  }, opts or {}, { persistent = true })

  local termkey = vim.inspect({ cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

  if terminals[termkey] and terminals[termkey]:buf_valid() then
    terminals[termkey]:toggle()
  else
    terminals[termkey] = require("lazy.util").float_term(cmd, opts)
    local buf = terminals[termkey].buf
    vim.b[buf].lazyterm_cmd = cmd
    if opts.esc_esc == false then
      vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
    end
    if opts.ctrl_hjkl == false then
      vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
  end

  return terminals[termkey]
end

function M.has_plugin(name)
  return require("lazy.core.config").plugins[name] ~= nil
end

function M.functionOrCommand(functionOrCmd)
  if type(functionOrCmd) == "function" then
    return functionOrCmd
  end

  if type(functionOrCmd) == "string" then
    return "<cmd>" .. functionOrCmd .. "<cr>"
  end
end

return M
