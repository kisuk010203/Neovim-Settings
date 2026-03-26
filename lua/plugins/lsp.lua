local keyMapper = require('utils.keyMapper').mapKey

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 
          "lua_ls", 
          "ts_ls",
          "rust_analyzer",
          "pyright", "ocamllsp" , "clangd"
        }
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.ts_ls.setup({})

      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },
          },
        },
      })
      lspconfig.pyright.setup({})
      lspconfig.coq_lsp.setup({})    -- Coq / Rocq
      lspconfig.ocamllsp.setup({})
      lspconfig.clangd.setup({
        cmd = {
          '/opt/homebrew/opt/llvm/bin/clangd',
          '--compile-commands-dir=build',
          '--query-driver=/opt/homebrew/opt/llvm/bin/clang++',
          '--clang-tidy',
        },
      })

      -- Enable inlay hints on attach for static-typed languages
      local inlay_hint_fts = { rust = true, ocaml = true, c = true, cpp = true }
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf
          if client and client.supports_method('textDocument/inlayHint')
            and inlay_hint_fts[vim.bo[bufnr].filetype] then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })

      -- vim.lsp.buf.hover
      -- vim.lsp.buf.definition
      -- vim.lsp.buf.code_action

      keyMapper('K', vim.lsp.buf.hover)
      keyMapper('gd', vim.lsp.buf.definition)
      keyMapper('<leader>ca', vim.lsp.buf.code_action)
      keyMapper('<leader>ih', function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
        vim.notify('Inlay hints ' .. (enabled and 'disabled' or 'enabled'))
      end)

      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
          source = 'if_many',
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = true,
        },
      })

    end
  },
}

