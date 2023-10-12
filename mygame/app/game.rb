class Game
  SPRITES = {
    player: "/sprites/Characters/green_character1.png",
    arrow: "/sprites/Items/weapon_hammer.png",
    background: "/sprites/sampleMap.png"
  }
  ARROW_SPEED = 15

  attr_reader :args, :player

  def tick(args)
    @args = args
    @player = args.state.player ||= {
      x: 720,
      y: 50
    }

    # while `a` key is down => move left
    if args.inputs.keyboard.key_held.a
      args.state.player.x -= 5
    end

    # while `d` key is down => move right
    if args.inputs.keyboard.key_held.d
      args.state.player.x += 5
    end

    # when space is pressed => shoot an arrow
    if args.inputs.keyboard.key_down.space
      arrow = {x: player.x, y: player.y, angle: 0}
      # add a little bit of a spicy random starting point
      arrow.x += rand(80) - 40
      # and double-shot!
      2.times { args.state.arrows << arrow.merge(x: player.x + rand(80) - 40) }
    end

    # update arrows: make them fly upwards and rotate
    args.state.arrows.each do |a|
      a.y += ARROW_SPEED
      a.angle += 35
    end
    # when they go off bounds, remove them
    args.state.arrows.reject! { |a| a.y >= 720 }


    # render everything!
    args.outputs.background_color = {r: 255, g: 255, b:255}
    # render arrows
    args.outputs.sprites << args.state.arrows.map do |a|
      {x: a.x, y: a.y, w: 64, h: 64, path: SPRITES.arrow, angle: a.angle}
    end
    # render player
    args.outputs.sprites << {
      x: args.state.player.x,
      y: args.state.player.y,
      w: 64,
      h: 64,
      path: SPRITES.player
    }
  end
end
