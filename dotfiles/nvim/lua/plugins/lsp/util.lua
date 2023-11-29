local M = {}

local function get_rename_filters(client)
  if client
      and client.server_capabilities
      and client.server_capabilities.workspace
      and client.server_capabilities.workspace.fileOperations
      and client.server_capabilities.workspace.fileOperations.willRename then
    return client.server_capabilities.workspace.fileOperations.willRename.filters
  end
  return nil
end

local function is_matching_pattern(pattern, name)
  local regex = vim.fn.glob2regpat(pattern.glob)
  if pattern.options and pattern.options.ignorecase then
    regex = "\\c" .. regex
  end

  local previous_ignorecase = vim.o.ignorecase
  vim.o.ignorecase = false
  local matched = vim.fn.match(name, regex) ~= -1
  vim.o.ignorecase = previous_ignorecase
  return matched
end

local function get_workspace_edit(client, from, to)
  local method_params = {
    files = {
      {
        oldUri = "file://" .. from,
        newUri = "file://" .. to,
      }
    }
  }
  local success, resp = pcall(client.request_sync, "workspace/willRenameFiles", method_params, 10000)
  if not success then
    vim.notify("Error while sending workspace/willRenameFiles request")
    return nil
  end
  if resp == nil or resp.result == nil then
    vim.notify("Got empty workspace/willRenameFiles response, maybe a timeout?")
    return nil
  end
  return resp.result
end

function M.rename_files_or_folder(from, to)
  for _, client in pairs(vim.lsp.get_clients()) do
    local filters = get_rename_filters(client)
    if filters then
      local stat = vim.uv.fs_stat(from)
      local is_dir = stat == "directory"
      for _, filter in pairs(filters) do
        local match_type = filter.pattern.matches
        if match_type and (
              (match_type == "folder" and is_dir) or
              (match_type == "file" and not is_dir)) then
          if is_matching_pattern(filter.pattern, from) then
            local edit_result = get_workspace_edit(client, from, to)
            if edit_result ~= nil then
              vim.lsp.util.apply_workspace_edit(edit_result, client.offset_encoding)
            end
          end
        end
      end
    end
  end
end

return M
