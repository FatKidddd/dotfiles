return {
  {
    '3rd/image.nvim',
    ft = 'markdown',
    build = false,
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      tmux_show_only_in_active_window = true,
      integrations = {
        markdown = {
          only_render_image_at_cursor = false,
          floating_windows = true,
        },
      },
      max_width_window_percentage = 90,
      max_height_window_percentage = 80,
    },
  },
  {
    'HakonHarnes/img-clip.nvim',
    ft = 'markdown',
    keys = {
      { '<leader>p', '<cmd>PasteImage<CR>', ft = 'markdown', desc = 'Paste image from clipboard' },
    },
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = true,
      },
    },
  },
}
