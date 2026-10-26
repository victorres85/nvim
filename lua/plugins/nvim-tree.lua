return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Global ignore patterns applied across all projects
    local global_ignore = {
      "^.aider",
      "^.venv$",
      "^.mypy_cache$",
      "^__pycache__$",
      "^.ruff_cache$",
      "^.pytest_cache$",
      "^.docs$",
      "^.nvim$",
      "^.agent$",
      "^.agents$",
      "^CONVENTIONS.md$",
      "^node_modules$",
    }

    require("nvim-tree").setup {
      filters = {
        custom = function(path)
          local ignore_list = vim.list_extend({}, global_ignore)

          -- Optional user-global ignores from vim.g.tree_ignore
          if type(vim.g.tree_ignore) == "table" then
            vim.list_extend(ignore_list, vim.g.tree_ignore)
          end

          -- Project-local ignores from .nvim.lua (vim.g.project.tree_ignore)
          local project = vim.g.project
          if type(project) == "table" and type(project.tree_ignore) == "table" then
            vim.list_extend(ignore_list, project.tree_ignore)
          end

          local basename = vim.fs.basename(path)
          for _, raw_pat in ipairs(ignore_list) do
            local pat = raw_pat:gsub("/+$", "")
            if
              basename == pat
              or vim.startswith(basename, pat)
              or vim.fn.match(basename, pat) ~= -1
              or vim.fn.match(path, pat) ~= -1
            then
              return true
            end
          end

          return false
        end,
      },
    }
  end,
}
