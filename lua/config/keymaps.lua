local mapKey = require("utils.keyMapper").mapKey

-- Neotree toggle
mapKey('<leader>e', ':Neotree toggle<cr>')

-- pane navigation
mapKey('<C-h>', '<C-w>h') -- left
mapKey('<C-j>', '<C-w>j') -- down
mapKey('<C-k>', '<C-w>k') -- uppp
mapKey('<C-l>', '<C-w>l') -- rght

-- buffer navigation
mapKey('<D-Left>', ':bp<cr>')
mapKey('<D-Right>', ':bn<cr>')

-- search
mapKey('<leader>h', ':nohl<cr>')

-- indent
mapKey('<', '<gv', 'v')
mapKey('>', '>gv', 'v')
