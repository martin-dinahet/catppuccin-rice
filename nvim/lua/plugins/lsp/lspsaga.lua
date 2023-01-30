require("lspsaga").setup({
  ui = {
    -- Currently, only the round theme exists
    theme = "round",
    -- This option only works in Neovim 0.9
    title = true,
    -- Border type can be single, double, rounded, solid, shadow.
    border = "single",
    winblend = 0,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "",
    diagnostic = "",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    kind = {},
  },
})


local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show cursor diagnostics
-- Like show_line_diagnostics, it supports passing the ++unfocus argument
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

local api = vim.api

local function get_colors()
  return {
    red = '#e95678',
    magenta = '#b33076',
    orange = '#FF8700',
    yellow = '#f7bb3b',
    green = '#afd700',
    cyan = '#36d0e0',
    blue = '#61afef',
    purple = '#CBA6F7',
    white = '#d1d4cf',
    black = '#1c1c19',
    gray = '#6e6b6b',
    fg = '#f2f2bf',
  }
end

local function theme_normal()
  local conf = api.nvim_get_hl_by_name('Normal', true)
  if conf.background then
    return conf.background
  end
  return 'NONE'
end

local function hi_define()
  local colors = get_colors()
  local bg = theme_normal()
  return {
    -- general
    TitleString = { fg = colors.fg },
    TitleIcon = { fg = colors.red },
    SagaBorder = { bg = bg, fg = colors.blue },
    SagaNormal = { bg = bg },
    SagaExpand = { fg = colors.red },
    SagaCollapse = { fg = colors.red },
    SagaBeacon = { bg = colors.magenta },
    -- code action
    ActionPreviewNormal = { link = 'SagaNormal' },
    ActionPreviewBorder = { link = 'SagaBorder' },
    ActionPreviewTitle = { fg = colors.purple, bg = bg },
    CodeActionNormal = { link = 'SagaNormal' },
    CodeActionBorder = { link = 'SagaBorder' },
    CodeActionText = { fg = colors.orange },
    CodeActionNumber = { fg = colors.green },
    -- finder
    FinderSelection = { fg = colors.cyan, bold = true },
    FinderFileName = { fg = colors.white },
    FinderCount = { link = 'Label' },
    FinderIcon = { fg = colors.cyan },
    FinderType = { fg = colors.purple },
    --finder spinner
    FinderSpinnerTitle = { fg = colors.magenta, bold = true },
    FinderSpinner = { fg = colors.magenta, bold = true },
    FinderPreviewSearch = { link = 'Search' },
    FinderVirtText = { fg = colors.red },
    FinderNormal = { link = 'SagaNormal' },
    FinderBorder = { link = 'SagaBorder' },
    FinderPreviewBorder = { link = 'SagaBorder' },
    -- definition
    DefinitionBorder = { link = 'SagaBorder' },
    DefinitionNormal = { link = 'SagaNormal' },
    DefinitionSearch = { link = 'Search' },
    -- hover
    HoverNormal = { link = 'SagaNormal' },
    HoverBorder = { link = 'SagaBorder' },
    -- rename
    RenameBorder = { link = 'SagaBorder' },
    RenameNormal = { fg = colors.orange, bg = bg },
    RenameMatch = { link = 'Search' },
    -- diagnostic
    DiagnosticBorder = { link = 'SagaBorder' },
    DiagnosticSource = { fg = 'gray' },
    DiagnosticNormal = { link = 'SagaNormal' },
    DiagnosticErrorBorder = { link = 'DiagnosticError' },
    DiagnosticWarnBorder = { link = 'DiagnosticWarn' },
    DiagnosticHintBorder = { link = 'DiagnosticHint' },
    DiagnosticInfoBorder = { link = 'DiagnosticInfo' },
    DiagnosticPos = { fg = colors.gray },
    DiagnosticWord = { fg = colors.fg },
    -- Call Hierachry
    CallHierarchyNormal = { link = 'SagaNormal' },
    CallHierarchyBorder = { link = 'SagaBorder' },
    CallHierarchyIcon = { fg = colors.purple },
    CallHierarchyTitle = { fg = colors.red },
    -- lightbulb
    LspSagaLightBulb = { link = 'DiagnosticSignHint' },
    -- shadow
    SagaShadow = { bg = colors.black },
    -- Outline
    OutlineIndent = { fg = colors.magenta },
    OutlinePreviewBorder = { link = 'SagaNormal' },
    OutlinePreviewNormal = { link = 'SagaBorder' },
    -- Float term
    TerminalBorder = { link = 'SagaBorder' },
    TerminalNormal = { link = 'SagaNormal' },
  }
end

local function init_highlight()
  for group, conf in pairs(hi_define()) do
    api.nvim_set_hl(0, group, vim.tbl_extend('keep', conf, { default = true }))
  end
end

return {
  init_highlight = init_highlight,
  get_colors = get_colors,
}
