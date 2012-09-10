Crafty.c "Planet",
  init: ->
    # random_planet = Crafty.math.randomInt 1, 15
    # random_format = _.shuffle(["tiny", "small", "medium", "big"])[0]
    random_planet = _.shuffle(["moon", "mars", "earth"])[0]
    @requires("2D, Canvas, planets_#{random_planet}")
      .origin("center")
      .attr
        y: -@h,
        x: Crafty.math.randomInt(@w, Crafty.viewport.width - @w),
        z: 0
        # random rotation
        rotation: Crafty.math.randomInt(0,360)
      .bind "EnterFrame", ->
        # destroy planets if they leave the viewport
        if @x > Crafty.viewport.width + @w || @x < -@w || @y < -@h || @y > Crafty.viewport.height + @h
          @destroy()
        # Move the Planet in game loop
        @y += 1
