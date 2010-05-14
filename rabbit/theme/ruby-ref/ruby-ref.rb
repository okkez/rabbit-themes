@block_quote_frame_width  = 1
@block_quote_fill_color   = "#eeeeee"

# FIXME
@default_item1_mark_color = "#000000"
@default_item2_mark_color = "#333333"
@default_item3_mark_color = "#666666"
@default_enum_item1_mark_color = "#333333"
@default_enum_item2_mark_color = "#666666"
@default_description_item1_mark_color = "#ff9933"
@default_block_quote_item1_mark_color = "#ff9933"

@description_term_line_color = "#3333aa"

@preformatted_frame_width = 1
@preformatted_fill_color  = "#eeeeee"

@table_frame_width     = 1
@table_caption_color   = "#000000"
@table_head_fill_color = "#dddddd"
@table_fill_color      = "#eeeeee"
include_theme("default")

set_foreground("black")
set_background("white")

match(Slide, HeadLine) do |heads|
  name = "head-line"

  heads.delete_post_draw_proc_by_name(name)

  heads.horizontal_centering = false
  heads.prop_set("foreground", "white")

  x_space = screen_x(2)
  y_space = screen_y(1)

  heads.padding_top    = y_space * 2
  heads.padding_bottom = y_space * 2

  color = "#3333aa"

  heads.each do |head|
    pre_y = nil
    width = nil
    height = nil
    head.add_pre_draw_proc(name) do |canvas, x, y, w, h, simulation|
      pre_y = y
      unless simulation
        border_x = x - x_space * 2
        border_y = y - y_space * 2
        border_width = width + x_space * 4
        border_height = height + y_space * 4
        canvas.draw_rectangle(true, border_x, border_y,
                              border_width, border_height, color)
      end
      [x, y, w, h]
    end
    head.add_post_draw_proc(name) do |canvas, x, y, w, h, simulation|
      width = w
      height = y - pre_y
      [x, y, w, h]
    end
  end
end
