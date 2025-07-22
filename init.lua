--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- Enable hybrid line numbers (absolute current line, relative others)
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Quit Neovim entirely with leader key
vim.keymap.set('n', '<leader>x', '<cmd>qa<CR>', { desc = 'E[x]it Neovim' })

-- Buffer management keymaps
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Buffer [n]ext' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<CR>', { desc = 'Buffer [p]revious' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Buffer [d]elete' })
vim.keymap.set('n', '<leader>bb', '<cmd>buffer #<CR>', { desc = 'Buffer switch to last' })

-- Tab management keymaps
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<CR>', { desc = 'Tab [n]ext' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabprev<CR>', { desc = 'Tab [p]revious' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabnew<CR>', { desc = 'Tab [c]reate new' })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Tab close (e[x]it)' })
vim.keymap.set('n', '<leader>tl', function()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  
  -- Get tab info
  local tabs = {}
  for i = 1, vim.fn.tabpagenr('$') do
    local buffers_in_tab = {}
    for _, buf in ipairs(vim.fn.tabpagebuflist(i)) do
      local name = vim.fn.bufname(buf)
      if name ~= '' then
        table.insert(buffers_in_tab, vim.fn.fnamemodify(name, ':t'))
      end
    end
    local current = i == vim.fn.tabpagenr() and ' [current]' or ''
    table.insert(tabs, {
      display = string.format('Tab %d: %s%s', i, table.concat(buffers_in_tab, ', '), current),
      tab_nr = i
    })
  end
  
  pickers.new({}, {
    prompt_title = 'Tabs',
    finder = finders.new_table {
      results = tabs,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.display,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd('tabnext ' .. selection.value.tab_nr)
      end)
      
      -- Add tab delete functionality
      map('i', '<C-x>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          local tab_nr = selection.value.tab_nr
          local current_tab = vim.fn.tabpagenr()
          
          -- Close the tab
          vim.cmd('tabclose ' .. tab_nr)
          
          -- Refresh the picker with updated tab list
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local new_tabs = {}
          for i = 1, vim.fn.tabpagenr('$') do
            local buffers_in_tab = {}
            for _, buf in ipairs(vim.fn.tabpagebuflist(i)) do
              local name = vim.fn.bufname(buf)
              if name ~= '' then
                table.insert(buffers_in_tab, vim.fn.fnamemodify(name, ':t'))
              end
            end
            local current = i == vim.fn.tabpagenr() and ' [current]' or ''
            table.insert(new_tabs, {
              display = string.format('Tab %d: %s%s', i, table.concat(buffers_in_tab, ', '), current),
              tab_nr = i
            })
          end
          current_picker:refresh(finders.new_table {
            results = new_tabs,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.display,
                ordinal = entry.display,
              }
            end,
          })
        end
      end)
      
      map('n', '<C-x>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          local tab_nr = selection.value.tab_nr
          vim.cmd('tabclose ' .. tab_nr)
          
          -- Refresh the picker
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local new_tabs = {}
          for i = 1, vim.fn.tabpagenr('$') do
            local buffers_in_tab = {}
            for _, buf in ipairs(vim.fn.tabpagebuflist(i)) do
              local name = vim.fn.bufname(buf)
              if name ~= '' then
                table.insert(buffers_in_tab, vim.fn.fnamemodify(name, ':t'))
              end
            end
            local current = i == vim.fn.tabpagenr() and ' [current]' or ''
            table.insert(new_tabs, {
              display = string.format('Tab %d: %s%s', i, table.concat(buffers_in_tab, ', '), current),
              tab_nr = i
            })
          end
          current_picker:refresh(finders.new_table {
            results = new_tabs,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.display,
                ordinal = entry.display,
              }
            end,
          })
        end
      end)
      
      map('n', 'dd', function()
        local selection = action_state.get_selected_entry()
        if selection then
          local tab_nr = selection.value.tab_nr
          vim.cmd('tabclose ' .. tab_nr)
          
          -- Refresh the picker
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local new_tabs = {}
          for i = 1, vim.fn.tabpagenr('$') do
            local buffers_in_tab = {}
            for _, buf in ipairs(vim.fn.tabpagebuflist(i)) do
              local name = vim.fn.bufname(buf)
              if name ~= '' then
                table.insert(buffers_in_tab, vim.fn.fnamemodify(name, ':t'))
              end
            end
            local current = i == vim.fn.tabpagenr() and ' [current]' or ''
            table.insert(new_tabs, {
              display = string.format('Tab %d: %s%s', i, table.concat(buffers_in_tab, ', '), current),
              tab_nr = i
            })
          end
          current_picker:refresh(finders.new_table {
            results = new_tabs,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.display,
                ordinal = entry.display,
              }
            end,
          })
        end
      end)
      
      return true
    end,
  }):find()
end, { desc = 'Tab [l]ist' })

-- Window management keymaps
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Window split [v]ertical' })
vim.keymap.set('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Window split [h]orizontal' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Window [d]elete/close' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Window [o]nly (close others)' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Window cycle' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Window equalize size' })
vim.keymap.set('n', '<leader>w+', '<C-w>+', { desc = 'Window increase height' })
vim.keymap.set('n', '<leader>w-', '<C-w>-', { desc = 'Window decrease height' })
vim.keymap.set('n', '<leader>w>', '<C-w>>', { desc = 'Window increase width' })
vim.keymap.set('n', '<leader>w<', '<C-w><', { desc = 'Window decrease width' })
vim.keymap.set('n', '<leader>wa', '<cmd>FocusToggle<CR>', { desc = 'Window [a]uto-resize toggle' })
vim.keymap.set('n', '<leader>wx', '<C-w>c', { desc = 'Window close (e[x]it split)' })

-- Floating terminal toggle
local function toggle_floating_terminal()
  -- Check if floating terminal buffer exists
  local floating_term_buf = vim.g.floating_term_buf
  local floating_term_win = vim.g.floating_term_win
  
  -- If window is open, close it
  if floating_term_win and vim.api.nvim_win_is_valid(floating_term_win) then
    vim.api.nvim_win_close(floating_term_win, true)
    vim.g.floating_term_win = nil
    return
  end
  
  -- If buffer doesn't exist or is invalid, create new one
  if not floating_term_buf or not vim.api.nvim_buf_is_valid(floating_term_buf) then
    floating_term_buf = vim.api.nvim_create_buf(false, true)
    vim.g.floating_term_buf = floating_term_buf
  end
  
  -- Calculate window dimensions (80% of screen)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  -- Open floating window
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded'
  }
  
  floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, win_config)
  vim.g.floating_term_win = floating_term_win
  
  -- Start terminal in the buffer if it's not already a terminal
  local buf_name = vim.api.nvim_buf_get_name(floating_term_buf)
  if not string.match(buf_name, '^term://') then
    vim.fn.termopen(vim.o.shell)
  end
  
  -- Enter insert mode
  vim.cmd('startinsert')
end

vim.keymap.set({'n', 't'}, '<M-i>', toggle_floating_terminal, { desc = 'Toggle floating terminal' })

-- Split keybindings (I think these fit well under leader-s for "split")
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = '[S]plit [v]ertical' })
vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = '[S]plit [h]orizontal' })
vim.keymap.set('n', '<leader>st', '<cmd>tabnew<CR>', { desc = '[S]plit new [t]ab' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = '[S]plit [e]qualize' })

-- File action keymaps
vim.keymap.set('n', '<leader>fp', function()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
  if relative_path == '' then
    vim.notify('No file open', vim.log.levels.WARN)
    return
  end
  vim.fn.setreg('+', relative_path)
  vim.notify('Copied to clipboard: ' .. relative_path, vim.log.levels.INFO)
end, { desc = '[F]ile copy [p]ath' })

vim.keymap.set('n', '<leader>fg', function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
  if file_path == '' then
    vim.notify('No file open', vim.log.levels.WARN)
    return
  end
  
  -- Get git remote URL
  local remote_url = vim.fn.system('git remote get-url origin 2>/dev/null'):gsub('\n', '')
  if vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repository or no origin remote', vim.log.levels.ERROR)
    return
  end
  
  -- Convert SSH URL to HTTPS if needed
  remote_url = remote_url:gsub('git@github%.com:', 'https://github.com/')
  remote_url = remote_url:gsub('%.git$', '')
  
  -- Get current branch
  local current_branch = vim.fn.system('git branch --show-current 2>/dev/null'):gsub('\n', '')
  if vim.v.shell_error ~= 0 then
    current_branch = 'main'
  end
  
  -- Create choice dialog
  local choices = {
    '&1. Open in master/main branch',
    '&2. Open in current branch (' .. current_branch .. ')',
  }
  
  vim.ui.select(choices, {
    prompt = 'Open file in GitHub:',
  }, function(choice, idx)
    if not choice then return end
    
    local branch = idx == 1 and 'main' or current_branch
    local line_number = vim.fn.line('.')
    local github_url = string.format('%s/blob/%s/%s#L%d', remote_url, branch, file_path, line_number)
    
    -- Try different commands to open URL
    local open_cmd
    if vim.fn.executable('open') == 1 then
      open_cmd = 'open'  -- macOS
    elseif vim.fn.executable('xdg-open') == 1 then
      open_cmd = 'xdg-open'  -- Linux
    elseif vim.fn.executable('start') == 1 then
      open_cmd = 'start'  -- Windows
    else
      vim.fn.setreg('+', github_url)
      vim.notify('URL copied to clipboard: ' .. github_url, vim.log.levels.INFO)
      return
    end
    
    vim.fn.system(string.format('%s "%s"', open_cmd, github_url))
    vim.notify('Opening in GitHub: ' .. github_url, vim.log.levels.INFO)
  end)
end, { desc = '[F]ile open [G]itHub' })

vim.keymap.set('n', '<leader>ff', function()
  -- Try conform.nvim first (if available), then LSP formatting, then built-in
  local conform_ok, conform = pcall(require, 'conform')
  if conform_ok then
    conform.format({ async = true, lsp_format = 'fallback' })
    vim.notify('Formatted with Conform', vim.log.levels.INFO)
  else
    -- Fallback to LSP formatting
    vim.lsp.buf.format({ async = true })
    vim.notify('Formatted with LSP', vim.log.levels.INFO)
  end
end, { desc = '[F]ile [f]ormat' })

vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[F]ile [s]ave' })

-- LSP "go to" keymaps (using 'g' prefix)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]o to [D]eclaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [i]mplementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]o to [r]eferences' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]o to [t]ype definition' })

-- Scratchpad keymaps
vim.keymap.set('n', '<leader>sn', function()
  -- Prompt for name and filetype
  vim.ui.input({ prompt = 'Scratch name (e.g., "api-test", "interview-prep"): ' }, function(name)
    if not name or name == '' then
      name = 'scratch-' .. os.date('%Y%m%d-%H%M%S')
    end
    
    vim.ui.select(
      { 'lua', 'ruby', 'typescript', 'javascript', 'python', 'go', 'rust', 'bash', 'json', 'yaml', 'markdown' },
      { prompt = 'Select language:' },
      function(filetype)
        if not filetype then return end
        
        local extensions = {
          lua = 'lua', ruby = 'rb', typescript = 'ts', javascript = 'js',
          python = 'py', go = 'go', rust = 'rs', bash = 'sh',
          json = 'json', yaml = 'yaml', markdown = 'md'
        }
        
        local filename = name .. '.' .. extensions[filetype]
        local scratch_dir = vim.fn.stdpath('cache') .. '/scratch.nvim'
        local filepath = scratch_dir .. '/' .. filename
        
        -- Ensure directory exists
        vim.fn.mkdir(scratch_dir, 'p')
        
        -- Open the file
        vim.cmd('edit ' .. filepath)
        
        -- Add header comment with description and date
        local header_lines = {
          '-- Scratch: ' .. name,
          '-- Created: ' .. os.date('%Y-%m-%d %H:%M:%S'),
          '-- Language: ' .. filetype,
          '',
          ''
        }
        
        -- Adjust comment style for different languages
        if filetype == 'python' or filetype == 'bash' then
          for i, line in ipairs(header_lines) do
            header_lines[i] = line:gsub('^%-%-', '#')
          end
        elseif filetype == 'javascript' or filetype == 'typescript' then
          for i, line in ipairs(header_lines) do
            header_lines[i] = line:gsub('^%-%-', '//')
          end
        elseif filetype == 'rust' or filetype == 'go' then
          for i, line in ipairs(header_lines) do
            header_lines[i] = line:gsub('^%-%-', '//')
          end
        elseif filetype == 'markdown' then
          for i, line in ipairs(header_lines) do
            header_lines[i] = line:gsub('^%-%-', '<!--') .. (line:match('%-%- (.+)') and ' -->' or '')
          end
          header_lines[1] = '<!-- Scratch: ' .. name .. ' -->'
          header_lines[2] = '<!-- Created: ' .. os.date('%Y-%m-%d %H:%M:%S') .. ' -->'
          header_lines[3] = '<!-- Language: ' .. filetype .. ' -->'
        end
        
        vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
        vim.api.nvim_win_set_cursor(0, {#header_lines, 0})
        vim.cmd('startinsert!')
      end
    )
  end)
end, { desc = '[S]cratch [n]ew (named)' })

vim.keymap.set('n', '<leader>so', '<cmd>ScratchOpen<CR>', { desc = '[S]cratch [o]pen' })
vim.keymap.set('n', '<leader>sl', '<cmd>ScratchOpenFzf<CR>', { desc = '[S]cratch [l]ist (Telescope)' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = { 
              ['<c-enter>'] = 'to_fuzzy_refine',
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<c-x>'] = 'delete_buffer', -- Delete buffer with Ctrl-x
              },
              n = {
                ['<c-x>'] = 'delete_buffer', -- Also works in normal mode
                ['dd'] = 'delete_buffer',    -- Delete with dd (like Vim)
              },
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      -- Servers managed by Mason
      local mason_servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        ts_ls = {},

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Servers using local installations (not managed by Mason)
      local local_servers = {
        ruby_lsp = {
          cmd = { '/Users/ryanzhou/.asdf/shims/ruby-lsp' }, -- Use full path to avoid asdf version issues
        },
      }

      -- Combine all servers for configuration
      local servers = vim.tbl_extend('force', mason_servers, local_servers)
      ---@type MasonLspconfigSettings
      ---@diagnostic disable-next-line: missing-fields
      require('mason-lspconfig').setup {
        automatic_enable = vim.tbl_keys(mason_servers),
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(mason_servers)
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configure all servers (Mason handles enabling Mason servers automatically)
      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, config)
      end

      -- Manually enable local servers (not managed by Mason)
      for server_name in pairs(local_servers) do
        vim.lsp.enable(server_name)
      end

      -- NOTE: Some servers may require an old setup until they are updated. For the full list refer here: https://github.com/neovim/nvim-lspconfig/issues/3705
      -- These servers will have to be manually set up with require("lspconfig").server_name.setup{}
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Session management - automatically save and restore sessions
  {
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },

  -- Scratchpad for quick notes and code snippets
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    opts = {
      scratch_file_dir = vim.fn.stdpath('cache') .. '/scratch.nvim', -- where to save scratch files
      window_cmd = 'edit', -- 'edit' | 'split' | 'vsplit' | 'tabedit'
      use_telescope = true, -- enable telescope integration
      localfile_name = '.scratch.lua', -- local scratch file name
    },
  },

  -- Auto-focus and resize windows
  {
    'nvim-focus/focus.nvim',
    version = '*',
    opts = {
      enable = true, -- Enable module
      commands = true, -- Create Focus commands
      autoresize = {
        enable = true, -- Enable or disable auto-resizing of splits
        width = 0, -- Force width(s) for focused window. 0 means no enforced width
        height = 0, -- Force height(s) for focused window. 0 means no enforced height
        minwidth = 0, -- Force minimum width(s) for unfocused windows
        minheight = 0, -- Force minimum height(s) for unfocused windows
        height_quickfix = 10, -- Set the height of quickfix panel
      },
      split = {
        bufnew = false, -- Create blank buffer for new split windows
        tmux = false, -- Create tmux splits instead of neovim splits
      },
      ui = {
        number = false, -- Display line numbers in the focussed window only
        relativenumber = false, -- Display relative line numbers in the focussed window only
        hybridnumber = false, -- Display hybrid line numbers in the focussed window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows
        cursorline = true, -- Display a cursorline in the focussed window only
        cursorcolumn = false, -- Display cursorcolumn in the focussed window only
        colorcolumn = {
          enable = false, -- Display colorcolumn in the foccused window only
          list = '+1', -- Set the comma-saperated list for the colorcolumn
        },
        signcolumn = true, -- Display signcolumn in the focussed window only
        winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
      }
    },
  },

  -- Start page/dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require('alpha.themes.dashboard')
      local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, '\n')
      
      -- Menu items
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '󰈞  Find file', ':Telescope find_files <CR>'),
        dashboard.button('r', '󰄉  Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', '󰊄  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('s', '  Restore Session', ':SessionRestore <CR>'),
        dashboard.button('l', '󰒲  Lazy', ':Lazy <CR>'),
        dashboard.button('m', '  Mason', ':Mason <CR>'),
        dashboard.button('q', '  Quit', ':qa <CR>'),
      }
      
      -- Set menu highlight
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.section.footer.opts.hl = 'AlphaFooter'
      
      -- Footer
      local function footer()
        return '🚀 Happy Coding!'
      end
      dashboard.section.footer.val = footer()
      
      dashboard.opts.layout = {
        { type = 'padding', val = 2 },
        dashboard.section.header,
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        { type = 'padding', val = 1 },
        dashboard.section.footer,
      }
      
      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end
      
      return dashboard
    end,
    config = function(_, dashboard)
      -- Close auto-session when opening dashboard
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        desc = 'disable status and tablines for alpha',
        callback = function()
          if vim.bo.filetype == 'alpha' then
            local prev_showtabline = vim.opt.showtabline
            local prev_status = vim.opt.laststatus
            vim.opt.showtabline = 0
            vim.opt.laststatus = 0
            vim.api.nvim_create_autocmd('BufUnload', {
              buffer = 0,
              callback = function()
                vim.opt.laststatus = prev_status
                vim.opt.showtabline = prev_showtabline
              end,
            })
          end
        end,
      })
      require('alpha').setup(dashboard.opts)
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
