-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'jake-stewart/multicursor.nvim'

return {
  'jake-stewart/multicursor.nvim',
  -- commit = '9eedebdd395bbbc4711081e33b0606c079e054c3', -- => branch = '1.0'
  branch = '1.0',
  lazy   = false,
  config = function()
    local mc = require('multicursor-nvim')
    mc.setup()

    local set = vim.keymap.set
    local nx = { 'n', 'x' } -- Normal, Visual
    local ll = '<localleader><localleader>'

    set(nx, '<M-q>', mc.toggleCursor, {nowait = true})

    -- add new cursor by matching word/selection
    set(nx, '<C-j>',    function() mc.matchAddCursor( 1) end)
    set(nx, '<C-k>',    function() mc.matchAddCursor(-1) end)

    -- add or skip cursor above/below the main cursor.
    set(nx, '<C-n>',    function() mc.lineAddCursor ( 1) end)
    set(nx, '<C-e>',    function() mc.lineAddCursor (-1) end)
    set(nx, '<S-M-n>',  function() mc.lineSkipCursor( 1) end)
    set(nx, '<S-M-e>',  function() mc.lineSkipCursor(-1) end)

    -- add and remove cursors with control + left click.
    set('n', '<c-leftmouse>',   mc.handleMouse)
    set('n', '<c-leftdrag>',    mc.handleMouseDrag)
    set('n', '<c-leftrelease>', mc.handleMouseRelease)

    set('x', 'A', mc.appendVisual) -- (standard) Append/insert for each line of visual selections.
    set('x', 'I', mc.insertVisual)

    set('x', 'M', mc.matchCursors) -- match new cursors within visual selections by regex.
    set('x', 'S', mc.splitCursors) -- Split visual selections by regex.

    -- align cursor columns. (funcion works only in Normal mode)
    set('n', ll..'a', mc.alignCursors, {desc='alignCursors'})

    -- add a cursor for all matches of cursor word/selection in the document.
    set(nx,  ll..'A', mc.matchAllAddCursors, {desc='matchAllAddCursors'})


    -- bring back cursors if you accidentally clear them
    set('n', ll..'R', mc.restoreCursors, {desc='restoreCursors'})

    -- Clone every cursor and disable the originals.
    set(nx,  ll..'<C-q>', mc.duplicateCursors, {desc='duplicateCursors'})

    -- Add a cursor to every search result in the buffer.
    -- set('n', ll..'S', mc.searchAllAddCursors, {desc='searchAllAddCursors'})

    -- Pressing ll..`miwap` will create a cursor in every match of the
    -- string captured by `iw` inside range `ap`.
    -- This action is highly customizable, see `:h multicursor-operator`.
    -- set(nx, ll..'m', mc.operator, {desc='operator'})

    set('n', 'ga',    mc.addCursorOperator, {desc='addCursorOperator'}) -- 'gaip' will add a cursor on each line of a paragraph.
    set(nx, 'g<c-a>', mc.sequenceIncrement, {desc='sequenceIncrement'}) -- Increment/decrement sequences,
    set(nx, 'g<c-x>', mc.sequenceDecrement, {desc='sequenceDecrement'}) -- treaing all cursors as one sequence.


    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Enable and clear cursors using escape.
      local clear_discard_cursors = function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end
      layerSet('n', '<esc>', function() clear_discard_cursors() end)
      layerSet('n', '<c-l>', function() clear_discard_cursors() end)

      layerSet(nx, '<C-q>',        mc.deleteCursor,             {nowait = true})
      layerSet(nx, 'q', function() mc.matchSkipCursor( 1) end,  {nowait = true})
      layerSet(nx, 'Q', function() mc.matchSkipCursor(-1) end,  {nowait = true})

      -- select a different cursor as the main one.
      layerSet(nx, '[', mc.prevCursor, {nowait = true})
      layerSet(nx, ']', mc.nextCursor, {nowait = true})

      -- add a cursor and jump to the next/previous search result.
      layerSet(nx, '}', function() mc.searchAddCursor( 1) end, {nowait = true})
      layerSet(nx, '{', function() mc.searchAddCursor(-1) end, {nowait = true})

      -- jump to the next/previous search result without adding a cursor.
      layerSet(nx, '<M-}>', function() mc.searchSkipCursor( 1) end, {nowait = true})
      layerSet(nx, '<M-{>', function() mc.searchSkipCursor(-1) end, {nowait = true})

      -- rotate the text contained in each visual selection between cursors.
      layerSet('x', ll..'t', function() mc.transposeCursors( 1) end, {desc='transposeCursors'})
      layerSet('x', ll..'T', function() mc.transposeCursors(-1) end, {desc='TransposeCursors'})

    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { reverse = true })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn'})
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { reverse = true })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn'})
  end
}
