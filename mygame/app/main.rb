# $gtk.set_window_fullscreen true

require_relative "slide"
require_relative "game"

# load and instantiate all slides
$scenes = $gtk.list_files("app/slides").map.with_index do |file, i|
  require_relative "slides/#{file}"
  Kernel.const_get("Slide#{i}").new
end

# add the game as the last scene
$scenes << Game.new

def tick args
  setup args
  args.outputs.background_color = {r: 0, g: 0, b: 0}

  scene = $scenes[args.state.current_scene]
  scene.tick(args)
end

def setup(args)
  args.state.current_scene ||= 0
  args.state.links ||= {}
  args.state.arrows ||= []
end

$gtk.reset
