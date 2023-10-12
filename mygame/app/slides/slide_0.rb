class Slide0 < Slide
  def render_slide
    title "Dragon Ruby"
    args.outputs.primitives << {
      x: (1280 - 128 * 1.8) / 2,
      y: 350,
      w: 128 * 1.8,
      h: 101 * 1.8,
      path: "dragonruby.png",
      angle: args.state.tick_count
    }.sprite!
    text "anyone?", x: 640, y: 240
  end
end
