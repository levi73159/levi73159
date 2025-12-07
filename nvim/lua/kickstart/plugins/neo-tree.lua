-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
local function is_neotree_open()
  local manager = require 'neo-tree.sources.manager'
  local renderer = require 'neo-tree.ui.renderer'

  -- Get the state for the 'filesystem' source
  local state = manager.get_state 'filesystem'

  -- Check if a window exists for that specific state
  return renderer.window_exists(state)
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
    },
    filesystem = {
      window = {
        mappings = {
          ['<leader>p'] = 'image_wezterm', -- " or another map
          ['\\'] = 'close_window',
        },
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
      },
    },
    commands = {
      image_wezterm = function(state)
        local node = state.tree:get_node()
        if node.type == 'file' then
          require('image_preview').PreviewImage(node.path)
        end
      end,
    },
  },
}
