-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
--vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'Olical/aniseed',  branch = 'develop' }
  use {'Olical/conjure',  branch = 'master', mod = 'conjure' }
  use 'nvim-lua/plenary.nvim'
  use 'L3MON4D3/LuaSnip'

  -- parsing system
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', mod= 'treesitter' }

  -- file searching
  use { 'nvim-telescope/telescope.nvim', requires = {
      'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
  mod = 'telescope'} 

  -- lsp
  use { 'neovim/nvim-lspconfig', mod = 'lspconfig' }

  -- autocomplete
  use { 'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'PaterJason/cmp-conjure' }, mod = 'cmp' }

  -- slime
  use 'jpalardy/vim-slime'
                                    
  -- themes
  use { 'folke/tokyonight.nvim', as = 'tokyonight' }
  use {'dracula/vim', as = 'dracula'}

  -- Clojure Stuff
  use { 'guns/vim-sexp', mod = 'sexp' }
  use { 'tpope/vim-sexp-mappings-for-regular-people', mod = 'sexp' }
  use { 'tpope/vim-repeat', mod = 'sexp' }
  use { 'tpope/vim-surround', mod = 'sexp' }
end)

