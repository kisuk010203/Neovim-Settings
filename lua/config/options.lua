local opt = vim.opt

-- tab and indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- visuals
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.showmatch = true
opt.signcolumn = "yes"

-- etc
opt.encoding = "UTF-8"
opt.cmdheight = 1
opt.scrolloff = 10
opt.mouse:append("a")
opt.clipboard="unnamedplus"
