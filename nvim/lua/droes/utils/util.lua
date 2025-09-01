local M = {}
local function check_directory_exists(directory)
  local uv = vim.loop
  return uv.fs_realpath(directory) ~= ""
end

--- Get all Lua files in a directory and return their values as a table.
---@param dir string
---@return table {} | nil
function M.get_files_and_value_as_table_from(dir)
  local directory = vim.fn.stdpath("config") .. "/lua/" .. dir
  if not check_directory_exists(directory) then
    print("Directory does not exist: " .. directory)
    return nil
  end

  local result_table = {}

  local files = vim.fn.globpath(directory, "*.lua", false, true)
  for _, filepath in ipairs(files) do
    local filename = vim.fn.fnamemodify(filepath, ":t:r")

    local ok, result_or_error = pcall(dofile, filepath)
    if ok then
      result_table[filename] = result_or_error
    else
      print("error:", filepath)
      print(result_or_error)
    end
  end

  return result_table
end

return M
