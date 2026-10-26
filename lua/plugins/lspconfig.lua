return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Per-project LSP settings via `.neoconf.json` (also reads `.vscode/settings.json`).
      -- NOTE: Must be set up before lspconfig, hence listed as a dependency.
      { 'folke/neoconf.nvim', opts = {} },

      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Format current buffer
          map('<leader>cf', function()
            vim.lsp.buf.format {
              async = true,
              filter = function(c)
                return c.name ~= 'ts_ls'
              end,
            }
          end, '[C]ode [F]ormat')

          -- Organize imports code action
          map('<leader>co', function()
            vim.lsp.buf.code_action {
              context = { only = { 'source.organizeImports' } },
              apply = true,
            }
          end, '[C]ode [O]rganize Imports')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'ruff' then
            -- Disable hover on ruff in favor of ty's hover provider
            client.server_capabilities.hoverProvider = false
          end
          if client and client.name == 'ts_ls' then
            -- Disable formatting on ts_ls so Biome is the sole formatter
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- Autoformat on save using attached LSP (Ruff, Biome, etc.)
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-format-on-save', { clear = true }),
        callback = function(event)
          local clients = vim.lsp.get_clients { bufnr = event.buf }
          local can_format = false
          for _, client in ipairs(clients) do
            if client:supports_method('textDocument/formatting') and client.name ~= 'ts_ls' then
              can_format = true
              break
            end
          end
          if can_format then
            vim.lsp.buf.format {
              bufnr = event.buf,
              filter = function(client)
                -- Biome formats JS/TS; never format with ts_ls
                return client.name ~= 'ts_ls'
              end,
            }
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Custom 'ty' and 'biome' LSP configurations (native vim.lsp.config, Nvim 0.11+).
      -- workspace_required = false keeps the old single_file_support behaviour.
      vim.lsp.config('ty', {
        cmd = { 'ty', 'server' },
        filetypes = { 'python' },
        root_markers = { 'ty.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
        workspace_required = false,
      })

      vim.lsp.config('biome', {
        cmd = { 'biome', 'lsp-proxy' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
          'jsonc',
        },
        root_markers = { 'biome.json', 'biome.jsonc', 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
        workspace_required = false,
      })

      -- Enable only Python, JavaScript/TypeScript, Terraform, and Lua (for Neovim config)
      local servers = {
        -- Python: Astral ty (type checker & LSP)
        ty = {},

        -- Python: Astral ruff (linter & formatter)
        ruff = {
          on_attach = function(client, _)
            -- Disable hover in favor of ty's hover provider
            client.server_capabilities.hoverProvider = false
          end,
        },

        -- JavaScript & TypeScript: Biome (linter & formatter)
        biome = {},

        -- TypeScript & JavaScript: ts_ls (type checking & symbol navigation)
        ts_ls = {
          settings = {
            typescript = {
              suggest = {
                autoImports = true,
                includeCompletionsForModuleExports = true,
              },
            },
            javascript = {
              suggest = {
                autoImports = true,
                includeCompletionsForModuleExports = true,
              },
            },
          },
          on_attach = function(client, _)
            -- Disable formatting so Biome handles formatting exclusively
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        -- Terraform
        terraformls = {},

        -- Lua (for Neovim config files)
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Mason setup for LSP configuration
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }

      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end

      -- User commands for LSP info and logs (compatibility for Neovim 0.11 / 0.12+)
      vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', { desc = 'LSP info (:checkhealth vim.lsp)' })
      vim.api.nvim_create_user_command('LspLog', function()
        vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
      end, { desc = 'Opens the Nvim LSP client log' })
    end,
  },
}
