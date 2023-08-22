--This removes the duplicated --INSERT-- status
vim.opt.showmode = false
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  opts = {
    options = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '|', right = '|' },
    },
    sections = {
      lualine_x = { 'filetype' }
    }
  },
}
