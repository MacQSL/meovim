return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  keys = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>;', builtin.find_files, {})
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

    vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pb', builtin.buffers, {})

    vim.keymap.set('n', '<leader>H', builtin.help_tags, {})

    -- dope!
    vim.keymap.set('n', '<leader>fn', builtin.treesitter, {})
  end,
}
