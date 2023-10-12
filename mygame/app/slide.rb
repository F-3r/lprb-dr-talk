class Slide
  attr_reader :args

  def tick(args)
    @args = args

    args.outputs.background_color = {r: 0, g: 0, b: 0}
    args.state.current_scene ||= 0
    args.state.links ||= {}

    if args.inputs.keyboard.key_down.right
      args.state.current_scene += 1
    end

    if args.inputs.keyboard.key_down.left
      args.state.current_scene -= 1
    end

    handle_link_click
    render_slide
  end

  def handle_link_click
    mouse = args.inputs.mouse
    links = args.state.links[args.state.current_scene]

    if links && links.any? && mouse.click
      link = links.values.detect { |l| mouse.intersect_rect? l.rect }
      $gtk.system "xdg-open #{link.url}" if link
    end
  end

  def title(text)
    text(text, x: 640, y: 640, size: 64, alignment: [:center, :middle])
  end

  def text(text, x:, y:, size: 32, alignment: [:center, :bottom], color: {r: 255, g: 255, b: 255, a: 255}, font: "fonts/joystix.otf")
    vertical_alignment_enum = case alignment.last
    when :bottom then 0
    when :middle then 1
    when :top then 2
    end

    horizontal_alignment_enum = case alignment.first
    when :left then 0
    when :center then 1
    when :right then 2
    end

    args.outputs.primitives << {x: x, y: y, text: text, size_px: size, alignment_enum: horizontal_alignment_enum, vertical_alignment_enum: vertical_alignment_enum, **color, font: font}.label!
  end

  def link(url, x:, y:, size: 32, font: "font/joystix.otf")
    size_enum = size * 0.5 - 11
    w, h = $gtk.calcstringbox(url, size_enum, font)
    rect = {x: x - w / 2, y: y, w: w, h: h}

    args.state.links[args.state.current_scene] ||= {}
    args.state.links[args.state.current_scene][url] ||= {
      rect: rect,
      url: url
    }

    text url, x: x, y: y, size: size, font: font
    args.outputs.primitives << rect.merge({r: 0, g: 255, b: 128, a: 50, primitive_marker: :solid})
  end
end
