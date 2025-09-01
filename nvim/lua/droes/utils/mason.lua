local mason_registry = require("mason-registry")

local M = {}

---Returns true if the package in installed in mason
---@param pkg_name string
---@return boolean
function M.is_pkg_installed(pkg_name)
  return mason_registry.get_package(pkg_name):is_installed()
end

---Returns the shared artifact path for a given package
---@param pkg_name string name of the package to get the path of
---@return string # path to the shared artifact directory of the package
function M.get_shared_path(pkg_name)
  return vim.fn.glob("$MASON/share/" .. pkg_name)
end

---@param pkg_list table
function M.ensure_installed(pkg_list)
  for _, pkg_name in ipairs(pkg_list) do
    local pkg = mason_registry.get_package(pkg_name)
    if not pkg:is_installed() then
      pkg:install()
    elseif pkg:get_installed_version() ~= pkg:get_latest_version() then
      -- print("not latest")
      pkg:install({
        version = pkg:get_latest_version(),
      })
    else
      -- print(pkg:get_installed_version())
      -- print(pkg:get_latest_version())
    end
  end
end

return M
