class Slide5 < Slide
  def render_slide
    title "Weird stuff"

    text "* gems? bundler?", x: 640, y: 520
    text "* mruby != Cruby != Dragon Ruby", x: 640, y: 440
    text "* pry? byebug? debugger?", x: 640, y: 360
    text "* File system?", x: 640, y: 280
    text "* docs", x: 640, y: 200
  end
end
