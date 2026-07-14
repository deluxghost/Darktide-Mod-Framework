local dmf_options_view_settings = {
  scrollbar_width = 10,
  max_visible_dropdown_options = 5,
  indentation_spacing = 40,
  shading_environment = "content/shading_environments/ui/system_menu",
  grid_size = {
    500,
    820 -- Increased to compensate for upshifted category grid
  },
  category_grid_spacing = {
    0,
    3
  },
  settings_grid_spacing = {
    0,
    10
  },
  settings_header_height = 140,
  settings_header_spacing = 20,
  category_filter_height = 44,
  category_filter_spacing = 12,
  grid_blur_edge_size = {
    8,
    8
  }
}

return settings("DMFOptionsViewSettings", dmf_options_view_settings)
