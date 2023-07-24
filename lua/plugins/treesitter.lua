return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    local ts_build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
    ts_build()
  end,
}
