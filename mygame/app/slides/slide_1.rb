class Slide1 < Slide
  def render_slide
    title "Dragon Ruby"

    link "https://dragonruby.itch.io/dragonruby-gtk", x: 640, y: 540

    text "Amir Rajan: ", x: 480, y: 400
    link "https://amirrajan.net", x: 760, y: 400

    text "Ryan Gordon:", x: 460, y: 360
    link "https://icculus.org/~icculus", x: 800, y: 360
  end
end
