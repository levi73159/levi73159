return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.g.codeium_disable_bindings = true
    vim.keymap.set('i', '<C-CR>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-n>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-p>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-k>', function()
      return vim.fn['codeium#AcceptNextWord']()
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-l>', function()
      return vim.fn['codeium#AcceptNextLine']()
    end, { expr = true, silent = true })
  end,
}
