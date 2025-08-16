local M = {}

local transparent_highlights = {
  'Normal',
  'NormalNC',
  'LineNr',
  'Folded',
  'NonText',
  'SpecialKey',
  'VertSplit',
  'SignColumn',
  'EndOfBuffer',
  'TablineFill', -- this might be preference
  'NormalFloat',
}

function M.setTransparentHighlights()
  for _, hl in ipairs(transparent_highlights) do
    vim.cmd.highlight(hl .. ' guibg=NONE ctermbg=NONE')
  end
end

return M
