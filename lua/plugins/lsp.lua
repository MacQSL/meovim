return {
  "neovim/nvim-lspconfig",
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "J", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.worspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    lspconfig.html.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.prismals.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern(".git")
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {

            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = { group = "module" },
            prefix = "self",
          },
          cargo = { buildScripts = { enable = true } },
          procMacro = { enable = true },
        }
      }

    })
  end,
}
--return {
--  "VonHeikemen/lsp-zero.nvim",
--  branch = "v1.x",
--  --ft = vim.g.supported_filetypes,
--  dependencies = {
--    { "neovim/nvim-lspconfig" },
--    { "williamboman/mason.nvim" },
--    { "williamboman/mason-lspconfig.nvim" },
--    { "hrsh7th/nvim-cmp" },
--    { "hrsh7th/cmp-buffer" },
--    { "hrsh7th/cmp-path" },
--    { "saadparwaiz1/cmp_luasnip" },
--    { "hrsh7th/cmp-nvim-lsp" },
--    { "hrsh7th/cmp-nvim-lua" },
--    { "L3MON4D3/LuaSnip" },
--    { "rafamadriz/friendly-snippets" },
--  },
--  config = function()
--    local lsp = require("lsp-zero")
--
--    lsp.preset("recommended")
--
--    lsp.ensure_installed({ "eslint" })
--    -- Fix Undefined global 'vim'
--    lsp.nvim_workspace()
--
--    local cmp = require("cmp")
--    local cmp_select = { behavior = cmp.SelectBehavior.Select }
--    local cmp_mappings = lsp.defaults.cmp_mappings({
--      ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
--      ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
--      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--      ["<C-Space>"] = cmp.mapping.complete(),
--    })
--
--    lsp.setup_nvim_cmp({
--      mapping = cmp_mappings,
--    })
--
--    lsp.set_preferences({
--      suggest_lsp_servers = false,
--    })
--
--    lsp.on_attach(function(client, bufnr)
--      local opts = { buffer = bufnr, remap = false }
--      local test = { buffer = bufnr, testing = true }
--
--      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--
--      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--      vim.keymap.set("n", "J", function() vim.lsp.buf.code_action() end, opts)
--      vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.worspace_symbol() end, opts)
--      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--      vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--      vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
--      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--    end)
--
--    lsp.setup()
--
--    vim.diagnostic.config({
--      virtual_text = true,
--    })
--  end,
--}
