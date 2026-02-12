local vim = vim
local Plug = vim.fn['plug#']

vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

vim.call('plug#begin')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug('joshdick/onedark.vim')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('mason-org/mason.nvim')
Plug('TheLeoP/powershell.nvim')
Plug('mfussenegger/nvim-dap')
Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')
vim.call('plug#end')

vim.cmd('silent! colorscheme onedark')

require('mason').setup()

--
-- CMP Setup
--
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippets.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, buf)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc="Hover Info"})
  vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, {desc="Quickfix Diagnostics"})
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {desc="Previous Diagnostic"})
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {desc="Next Diagnostic"})
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {desc="Explain Diagnostic"})


	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end


--
-- PowerShell Config
--
require('powershell').setup({
  bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  capabilities = capabilities,
  on_attach = lsp_attach
})

local augroup = vim.api.nvim_create_augroup('personal-powershell', { clear = true })
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  group = augroup,
  pattern = {"*.ps1", "*.psm1", "*.psd1"},
  -- pattern = "powershell.nvim-term",
  callback = function(opts)
    -- print(string.format('event fired: %s', vim.inspect(opts)))
    vim.keymap.set('n', '<leader>P', function()
      require("powershell").toggle_term()
    end, { buffer = opts.buf })

    vim.keymap.set({"n", "x"}, "<leader>E", function()
      require("powershell").eval()
    end)

    vim.keymap.set("n", "<leader>D", function()
      require("dap").continue()
    end)
  end
})

--
-- nvim-tree Config
--
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>F', function(opts)
  require("nvim-tree.api").tree.toggle()
end)
