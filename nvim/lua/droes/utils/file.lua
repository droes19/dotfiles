local path = require("droes.utils.path")

local List = require("droes.utils.list")

local M = {}

function M.resolve_paths(root, paths)
  return List:new(paths)
    :map(function(path_pattern)
      return vim.fn.glob(path.join(root, path_pattern), true, true)
    end)
    :flatten()
end

return M
