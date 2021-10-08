require('plugin')
-- require('lua/config/plugin/lspconfig')
-- require('lua/config/plugin/cmp')


-- Settings
vim.opt.modifiable = true
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.number = true
vim.opt.wildmenu = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.grepprg = "rg -n --color auto"

-- we don't need ctags d/t LSP, but would be nice to fix it
-- v
-- im.opt.tags = true

-- finding files
vim.opt.path:append('**')

vim.opt.completeopt:remove('preview')
vim.opt.completeopt:append('menu', 'menuone', 'noselect', 'hover')

vim.cmd 'source ~/.config/nvim/lua/auto_cmds/tab_or_complete.vim'

-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1',
  'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- todo -- put this in it's own file
-- Rebind Keys
local map = vim.api.nvim_set_keymap

-- Leader and Local Leader
map('n', ' ', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = 'm'

-- other keys
--map('i', '<Tab>', 'tab_or_complete', { noremap = true })
--map('i', '<Tab> <C-R>' tab_or_complete, { noremap = true })
map('n', '<Leader>h', ':noh<CR>', { noremap = true})
map('n', '<Leader><Leader>', ':', { noremap = true})
map('n', '<Leader>w', '<C-w>', { noremap = true})
map('n', '<Leader>fs', ':w<CR>', { noremap = true})
map('n', '<Leader>bp', ':bp<CR>', { noremap = true})
map('n', '<Leader>bn', ':bn<CR>', { noremap = true})
map('n', '<Leader>bd', ':bd<CR>', { noremap = true})
map('n', '<Leader>ls', ':ls<CR>', { noremap = true})
map('n', '<Leader>bs', ':new<CR>', { noremap = true})
map('n', '<Leader>wd', ':q<CR>', { noremap = true})

-- make escape work nicely on terminal
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true})
map('t',  '<M-[>', '<Esc>', { noremap = true})


-- telescope commands
map('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true})
map('n', '<Leader>rg', '<cmd>Telescope live_grep<CR>', { noremap = true})
map('n', '<Leader>bb', '<cmd>Telescope buffers<CR>', { noremap = true})
map('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true})
map('n', '<Leader>fl', '<cmd>Telescope git_files<CR>', { noremap = true})

-- Save for extentions
--

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- colors
vim.g.tokyonight_style = 'night'
vim.cmd 'colorscheme tokyonight'

-------- LSP CONFIG -----------------
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clojure_lsp', 'tsserver', 'bashls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

------------ CMP CONFIG ---------

local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.

        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    completion = { autocomplete = false,
                   completeopt = 'menu,menuone,noinsert' },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = cmp.mapping.complete({ 'i' }),
      ['j'] = cmp.mapping.select_next_item( { 's' }),
      ['k'] = cmp.mapping.select_prev_item( { 's' }),
      ['<Esc>'] = cmp.mapping.close( {'s'} ),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'conjure' },
      { name = 'buffer' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

    }
  })


---- Treesitter Config -------
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- parser_configs.norg = {
--     install_info = {
--         url = "https://github.com/vhyrro/tree-sitter-norg",
--         files = { "src/parser.c", "src/scanner.cc" },
--         branch = "main"
--     },
-- }

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  }
}
