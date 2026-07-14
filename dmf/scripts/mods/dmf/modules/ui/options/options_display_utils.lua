local METADATA_LABEL_COLOR = "{#color(226,199,126)}"
local COLOR_RESET = "{#reset()}"

local OptionsDisplayUtils = {}

OptionsDisplayUtils.metadata_text = function (version, author)
  local parts = {}

  if version ~= nil and tostring(version) ~= "" then
    parts[#parts + 1] = COLOR_RESET .. METADATA_LABEL_COLOR .. "\u{e033}" .. COLOR_RESET .. " " .. tostring(version)
  end

  if author ~= nil and tostring(author) ~= "" then
    parts[#parts + 1] = COLOR_RESET .. METADATA_LABEL_COLOR .. "\u{e005}" .. COLOR_RESET .. " " .. tostring(author)
  end

  return table.concat(parts, "  ")
end

return OptionsDisplayUtils
