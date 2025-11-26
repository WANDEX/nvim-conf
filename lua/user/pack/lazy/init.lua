-- AUTHOR: 'WANDEX/nvim-conf'

require('user.pack.lazy.lazy').load({ -- lazy spec load
  profiling = {
    -- loader = true,  -- debug tab extra stats: loader cache + package.loaders.
    -- require = true, -- track each new require in the Lazy profiling tab
  },
})
