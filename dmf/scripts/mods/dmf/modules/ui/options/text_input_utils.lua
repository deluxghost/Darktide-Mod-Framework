local TextInputUtils = {}

local VALID_TEXT_CHANNEL = 255
local INVALID_TEXT_CHANNEL = 70

TextInputUtils.clear_selection = function (content)
  content.selected_text = nil
  content._selection_start = nil
  content._selection_end = nil
  content._selection_changed = nil
  content._is_selecting = nil
  content.last_input = nil
end

TextInputUtils.update_validation_style = function (style, is_valid)
  local text_color = style.display_text.text_color

  text_color[2] = VALID_TEXT_CHANNEL
  text_color[3] = is_valid and VALID_TEXT_CHANNEL or INVALID_TEXT_CHANNEL
  text_color[4] = is_valid and VALID_TEXT_CHANNEL or INVALID_TEXT_CHANNEL
end

return TextInputUtils
