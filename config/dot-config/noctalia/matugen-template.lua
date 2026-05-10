local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    -- Background tones
    base00 = '{{colors.surface.default.hex}}',              -- Default Background
    base01 = '{{colors.surface_container_lowest.default.hex}}', -- Lighter Background (status bars)
    base02 = '{{colors.surface_container_low.default.hex}}', -- Selection Background
    base03 = '{{colors.outline_variant.default.hex}}',      -- Comments, Invisibles
    -- Foreground tones
    base04 = '{{colors.on_surface_variant.default.hex}}',   -- Dark Foreground (status bars)
    base05 = '{{colors.on_surface.default.hex}}',           -- Default Foreground
    base06 = '{{colors.inverse_on_surface.default.hex}}',   -- Light Foreground
    base07 = '{{colors.surface_bright.default.hex}}',       -- Lightest Foreground
    -- Accent colors
    base08 = '{{colors.tertiary.default.hex | lighten: -5}}', -- Variables, XML Tags, Errors
    base09 = '{{colors.tertiary.default.hex}}',             -- Integers, Constants
    base0A = '{{colors.secondary.default.hex}}',            -- Classes, Search Background
    base0B = '{{colors.primary.default.hex}}',              -- Strings, Diff Inserted
    base0C = '{{colors.tertiary_container.default.hex}}',   -- Regex, Escape Chars
    base0D = '{{colors.primary_container.default.hex}}',    -- Functions, Methods
    base0E = '{{colors.secondary_container.default.hex}}',  -- Keywords, Storage
    base0F = '{{colors.secondary.default.hex | lighten: -10}}', -- Deprecated, Embedded Tags
  })

  -- Helper function to set multiple highlight groups at once
  local function set_hl_multiple(groups, value)
    for _, v in pairs(groups) do
      vim.api.nvim_set_hl(0, v, value)
    end
  end

  -- Make selected text stand out more
  vim.api.nvim_set_hl(0, 'Visual', {
    bg = '{{colors.primary_container.default.hex}}',
    fg = '{{colors.on_primary_container.default.hex}}',
  })

  -- Make "string" text contrast better
  set_hl_multiple({ 'String', 'TSString' }, {
    fg = '{{colors.tertiary.default.hex | lighten: -15.0}}',
  })

  -- Grey out comments
  set_hl_multiple({ 'TSComment', 'Comment' }, {
    fg = '{{colors.outline.default.hex}}',
    italic = true,
  })

  set_hl_multiple({ 'TSMethod', 'Method' }, {
    fg = '{{colors.tertiary.default.hex}}',
  })

  set_hl_multiple({ 'TSFunction', 'Function' }, {
    fg = '{{colors.secondary.default.hex}}',
  })

  set_hl_multiple({ 'Keyword', 'TSKeyword', 'TSKeywordFunction', 'TSRepeat' }, {
    fg = '{{colors.inverse_primary.default.hex}}',
  })
end

return M
