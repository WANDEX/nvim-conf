-- configuration for the plugin 'nvim-tree/nvim-tree.lua'

local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- copy/yank
  vim.keymap.set('n', 'yy',       api.fs.copy.node,                     opts('Yank'))
  vim.keymap.set('n', 'yp',       api.fs.copy.absolute_path,            opts('Yank Absolute Path'))
  vim.keymap.set('n', 'yn',       api.fs.copy.filename,                 opts('Yank Name'))
  vim.keymap.set('n', 'yr',       api.fs.copy.relative_path,            opts('Yank Relative Path'))

  -- rename
  vim.keymap.set('n', 'rs',       api.fs.rename_sub,                    opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'rn',       api.fs.rename_basename,               opts('Rename: Basename'))
  vim.keymap.set('n', 'rr',       api.fs.rename,                        opts('Rename'))
  vim.keymap.set('n', 'rp',       api.fs.rename_full,                   opts('Rename: Full Path'))
  vim.keymap.set('n', 'rR',       api.tree.reload,                      opts('Refresh'))

  -- run
  vim.keymap.set('n', '.',        api.node.run.cmd,                     opts('Run Command'))
  vim.keymap.set('n', 'S',        api.node.run.system,                  opts('Run System'))
  vim.keymap.set('n', '<C-k>',    api.node.show_info_popup,             opts('Info'))

  -- open
  vim.keymap.set('n', '<C-e>',    api.node.open.replace_tree_buffer,    opts('Open: In Place'))
  vim.keymap.set('n', '<C-t>',    api.node.open.tab,                    opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>',    api.node.open.vertical,               opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>',    api.node.open.horizontal,             opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<CR>',     api.node.open.edit,                   opts('Open'))
  vim.keymap.set('n', '<Tab>',    api.node.open.preview,                opts('Open Preview'))
  vim.keymap.set('n', 'o',        api.node.open.edit,                   opts('Open'))
  vim.keymap.set('n', 'O',        api.node.open.no_window_picker,       opts('Open: No Window Picker'))

  -- filter
  vim.keymap.set('n', 'B',        api.tree.toggle_no_buffer_filter,     opts('Toggle Filter: No Buffer'))
  vim.keymap.set('n', 'C',        api.tree.toggle_git_clean_filter,     opts('Toggle Filter: Git Clean'))
  vim.keymap.set('n', 'F',        api.live_filter.clear,                opts('Live Filter: Clear'))
  vim.keymap.set('n', 'f',        api.live_filter.start,                opts('Live Filter: Start'))
  vim.keymap.set('n', 'H',        api.tree.toggle_hidden_filter,        opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I',        api.tree.toggle_gitignore_filter,     opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', 'U',        api.tree.toggle_custom_filter,        opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'M',        api.tree.toggle_no_bookmark_filter,   opts('Toggle Filter: No Bookmark'))

  -- bmark
  vim.keymap.set('n', 'm',        api.marks.toggle,                     opts('Toggle Bookmark'))
  vim.keymap.set('n', 'bd',       api.marks.bulk.delete,                opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bt',       api.marks.bulk.trash,                 opts('Trash Bookmarked'))
  vim.keymap.set('n', 'bmv',      api.marks.bulk.move,                  opts('Move Bookmarked'))

  -- navigate
  vim.keymap.set('n', '<BS>',     api.node.navigate.parent_close,       opts('Close Directory'))
  vim.keymap.set('n', '>',        api.node.navigate.sibling.next,       opts('Next Sibling'))
  vim.keymap.set('n', '<',        api.node.navigate.sibling.prev,       opts('Previous Sibling'))
  vim.keymap.set('n', '[c',       api.node.navigate.git.prev,           opts('Prev Git'))
  vim.keymap.set('n', ']c',       api.node.navigate.git.next,           opts('Next Git'))
  vim.keymap.set('n', ']d',       api.node.navigate.diagnostics.next,   opts('Next Diagnostic'))
  vim.keymap.set('n', '[d',       api.node.navigate.diagnostics.prev,   opts('Prev Diagnostic'))
  vim.keymap.set('n', 'J',        api.node.navigate.sibling.last,       opts('Last Sibling'))
  vim.keymap.set('n', 'K',        api.node.navigate.sibling.first,      opts('First Sibling'))
  -- vim.keymap.set('n', 'P',        api.node.navigate.parent,             opts('Parent Directory'))

  -- fs
  vim.keymap.set('n', 'a',        api.fs.create,                        opts('Create File Or Directory'))
  vim.keymap.set('n', 'dd',       api.fs.cut,                           opts('Cut'))
  vim.keymap.set('n', 'D',        api.fs.remove,                        opts('Delete'))
  vim.keymap.set('n', 'dD',       api.fs.trash,                         opts('Trash'))
  vim.keymap.set('n', 'p',        api.fs.paste,                         opts('Paste'))
  vim.keymap.set('n', '<C-c>',    api.fs.print_clipboard,               opts('Clipboard Content'))

  -- tree
  vim.keymap.set('n', 'W',        api.tree.collapse_all,                opts('Collapse'))
  vim.keymap.set('n', 'E',        api.tree.expand_all,                  opts('Expand All'))
  vim.keymap.set('n', '<C-]>',    api.tree.change_root_to_node,         opts('CD'))
  vim.keymap.set('n', '<C-[>',    api.tree.change_root_to_parent,       opts('CD Parent'))
  vim.keymap.set('n', '?',        api.tree.toggle_help,                 opts('Help'))
  vim.keymap.set('n', 'q',        api.tree.close,                       opts('Close'))
  vim.keymap.set('n', 's',        api.tree.search_node,                 opts('Search'))

  -- mouse
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,             opts('Open'))
  vim.keymap.set('n', '<RightMouse>',   api.node.open.preview,          opts('Open Preview'))
  vim.keymap.set('n', '<MiddleMouse>',  api.tree.change_root_to_node,   opts('CD'))

  -- custom map
  vim.keymap.set('n', '+',        '<cmd>NvimTreeResize +10<CR>',        opts('NvimTreeResize +10'))
  vim.keymap.set('n', '-',        '<cmd>NvimTreeResize -10<CR>',        opts('NvimTreeResize +10'))
  vim.keymap.set('n', '=',        '<cmd>NvimTreeResize  30<CR>',        opts('NvimTreeResize  30'))
end

nvim_tree.setup{
  on_attach = my_on_attach,
  sort = {
    sorter = "name",
  },
  help = {
    sort_by = "key",
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
      symlink_arrow = " -> ",
    },
  },
  filters = {
    git_ignored = false,
    dotfiles = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },
  diagnostics = {
    enable = true,
  },
  notify = {
    threshold = vim.log.levels.WARNING,
  },
}

map('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>',                       {desc='NvimTreeToggle'})
map('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>',                     {desc='NvimTreeFindFile'})

