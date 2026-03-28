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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
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
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.coq_lsp.setup({ capabilities = capabilities })    -- Coq / Rocq
      lspconfig.ocamllsp.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({
        capabilities = capabilities,
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

      local telescope = require('telescope.builtin')

      keyMapper('K', vim.lsp.buf.hover)
      keyMapper('gd', vim.lsp.buf.definition)
      keyMapper('gi', vim.lsp.buf.implementation)
      keyMapper('gr', telescope.lsp_references)
      keyMapper('<leader>D', vim.lsp.buf.type_definition)
      keyMapper('<leader>rn', vim.lsp.buf.rename)
      keyMapper('<leader>ca', vim.lsp.buf.code_action)
      keyMapper('<leader>fw', telescope.lsp_workspace_symbols)
      keyMapper(']d', vim.diagnostic.goto_next)
      keyMapper('[d', vim.diagnostic.goto_prev)
      keyMapper('<leader>od', vim.diagnostic.open_float)
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

