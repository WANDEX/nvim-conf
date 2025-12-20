-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-tree/nvim-tree.lua'

local function wndx_nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, remap = false, silent = true, nowait = true }
  end

  local function expand_or_edit()
    local node = api.tree.get_node_under_cursor()
    if node.nodes ~= nil then
      if not node.open then -- to only expand folder without collapse
        api.node.open.edit(node)
      end
      api.node.navigate.sibling.first(node.nodes[1]) -- get inside dir/focus first sibling
    else
      api.node.open.edit() -- open file
      api.tree.close()     -- close the tree if file was opened
    end
  end

  -- colemak
  vim.keymap.set('n', 'h',        api.node.navigate.parent_close,       opts 'Close Directory' )
  vim.keymap.set('n', 'i',        expand_or_edit,                       opts 'Expand Or Edit' )

  -- copy/yank
  vim.keymap.set('n', 'yy',       api.fs.copy.node,                     opts 'Yank' )
  vim.keymap.set('n', 'yp',       api.fs.copy.absolute_path,            opts 'Yank Absolute Path' )
  vim.keymap.set('n', 'yn',       api.fs.copy.filename,                 opts 'Yank Name' )
  vim.keymap.set('n', 'yr',       api.fs.copy.relative_path,            opts 'Yank Relative Path' )

  -- rename
  vim.keymap.set('n', 'rs',       api.fs.rename_sub,                    opts 'Rename: Omit FName' )
  vim.keymap.set('n', 'rn',       api.fs.rename_basename,               opts 'Rename: Basename' )
  vim.keymap.set('n', 'rr',       api.fs.rename,                        opts 'Rename' )
  vim.keymap.set('n', 'rp',       api.fs.rename_full,                   opts 'Rename: Full Path' )
  vim.keymap.set('n', 'rR',       api.tree.reload,                      opts 'Refresh' )

  -- run
  vim.keymap.set('n', '.',        api.node.run.cmd,                     opts 'Run Command' )
  vim.keymap.set('n', 'S',        api.node.run.system,                  opts 'Run System' )
  vim.keymap.set('n', '<C-k>',    api.node.show_info_popup,             opts 'Info' )

  -- open
  vim.keymap.set('n', '<C-t>',    api.node.open.tab,                    opts 'Open: New Tab' )
  vim.keymap.set('n', '<C-v>',    api.node.open.vertical,               opts 'Open: Vert Split' )
  vim.keymap.set('n', '<C-x>',    api.node.open.horizontal,             opts 'Open: Horz Split' )
  vim.keymap.set('n', '<Tab>',    api.node.open.preview,                opts 'Open Preview' )

  -- filter
  vim.keymap.set('n', 'f',        api.live_filter.start,                opts 'Filter' )
  -- vim.keymap.set('n', 'F',        api.live_filter.clear,                opts 'Filter: Clear' )
  vim.keymap.set('n', 'B',        api.tree.toggle_no_buffer_filter,     opts 'FilterT: No Buffer' )
  vim.keymap.set('n', 'C',        api.tree.toggle_git_clean_filter,     opts 'FilterT: Git Clean' )
  vim.keymap.set('n', 'H',        api.tree.toggle_hidden_filter,        opts 'FilterT: Dotfiles' )
  vim.keymap.set('n', 'I',        api.tree.toggle_gitignore_filter,     opts 'FilterT: Git Ignore' )
  vim.keymap.set('n', 'U',        api.tree.toggle_custom_filter,        opts 'FilterT: Hidden' )
  vim.keymap.set('n', 'M',        api.tree.toggle_no_bookmark_filter,   opts 'FilterT: No Bookmark' )

  -- bmark
  vim.keymap.set('n', 'm',        api.marks.toggle,                     opts 'Bookmark   Toggle' )
  vim.keymap.set('n', 'bd',       api.marks.bulk.delete,                opts 'Bookmarked Delete' )
  vim.keymap.set('n', 'bt',       api.marks.bulk.trash,                 opts 'Bookmarked Trash' )
  vim.keymap.set('n', 'bmv',      api.marks.bulk.move,                  opts 'Bookmarked Move' )

  -- navigate
  vim.keymap.set('n', '[c',       api.node.navigate.git.prev,           opts 'Prev Git' )
  vim.keymap.set('n', ']c',       api.node.navigate.git.next,           opts 'Next Git' )
  vim.keymap.set('n', ']d',       api.node.navigate.diagnostics.next,   opts 'Next Diagnostic' )
  vim.keymap.set('n', '[d',       api.node.navigate.diagnostics.prev,   opts 'Prev Diagnostic' )
  vim.keymap.set('n', '>',        api.node.navigate.sibling.next,       opts 'Sibling Next' )
  vim.keymap.set('n', '<',        api.node.navigate.sibling.prev,       opts 'Sibling Prev' )
  vim.keymap.set('n', 'J',        api.node.navigate.sibling.last,       opts 'Sibling Last' )
  vim.keymap.set('n', 'K',        api.node.navigate.sibling.first,      opts 'Sibling First' )
  -- vim.keymap.set('n', 'P',        api.node.navigate.parent,             opts 'Parent Directory' )
  vim.keymap.set('n', '<BS>', '<nop>', { buffer = bufnr }) -- default <BS> causes some weird redraw

  -- fs
  vim.keymap.set('n', 'a',        api.fs.create,                        opts 'Create File Or Dir' )
  vim.keymap.set('n', 'dd',       api.fs.cut,                           opts 'Cut' )
  vim.keymap.set('n', 'D',        api.fs.remove,                        opts 'Delete' )
  -- vim.keymap.set('n', 'dD',       api.fs.trash,                         opts 'Trash' )
  vim.keymap.set('n', 'p',        api.fs.paste,                         opts 'Paste' )
  vim.keymap.set('n', '<C-c>',    api.fs.print_clipboard,               opts 'Clipboard Content' )

  --- tree
  --- NOTE: <C-[> key has the same key code as ESC, thus do not map on it,
  --- to avoid accidetal ESC key press behavior.
  --- vim.keymap.set('n', '<C-[>',api.tree.change_root_to_parent,       opts 'CD Parent' )
  vim.keymap.set('n', '<C-]>',    api.tree.change_root_to_node,         opts 'CD' )
  vim.keymap.set('n', 'tc',       api.tree.collapse_all,                opts 'Collapse' )
  vim.keymap.set('n', 'te',       api.tree.expand_all,                  opts 'Expand All' )
  vim.keymap.set('n', '?',        api.tree.toggle_help,                 opts 'Help' )
  vim.keymap.set('n', 'q',        api.tree.close,                       opts 'Close' )
  vim.keymap.set('n', 's',        api.tree.search_node,                 opts 'Search node regex' )

  -- custom map
  vim.keymap.set('n', '+',        '<cmd>NvimTreeResize +10<CR>',        opts 'NvimTreeResize +10' )
  vim.keymap.set('n', '-',        '<cmd>NvimTreeResize -10<CR>',        opts 'NvimTreeResize +10' )
  vim.keymap.set('n', '=',        '<cmd>NvimTreeResize  30<CR>',        opts 'NvimTreeResize  30' )

  -- mouse
  -- vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,             opts 'Open' )
  -- vim.keymap.set('n', '<RightMouse>',   api.node.open.preview,          opts 'Open Preview' )
  -- vim.keymap.set('n', '<MiddleMouse>',  api.tree.change_root_to_node,   opts 'CD' )
end

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  event = { 'VeryLazy' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      mode = 'n', '<leader>nt', '<cmd>NvimTreeToggle<CR>',
      desc = 'NvimTreeToggle',
    },
    {
      mode = 'n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>',
      desc = 'NvimTreeFindFile',
    },
  },
  opts = {
    on_attach = wndx_nvim_tree_on_attach,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    sort = {
      sorter = 'name',
    },
    help = {
      sort_by = 'desc',
    },
    view = {
      width = 30,
    },
    renderer = {
      add_trailing = false,
      group_empty  = true,
      full_name    = true,  -- Display node name in fwin if wider than the width of nvim-tree window
      indent_width = 2,
      symlink_destination = true,
      icons = {
        symlink_arrow = '  ',
        show = {
          git = false, -- removes weird indentation before the dir which contains git changes
        },
      },
    },
    filters = {
      git_ignored = false,
      dotfiles = true,
    },
    live_filter = {
      prefix = '[FILTER]: ',
      always_show_folders = false,
    },
    diagnostics = {
      enable = true,
    },
    notify = {
      threshold = vim.log.levels.WARN,
    },
  },
}
