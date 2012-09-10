Crafty.c "Bullet",
  init: ->
    @requires("2D, DOM, Color")
      .attr({ h: 7, w: 3, z: 50 })
      .bind "EnterFrame", ->
        if @_x > Crafty.viewport.width || @_x < 0 || @_y > Crafty.viewport.height || @_y < 0
          @destroy()
    return this

Crafty.c "PlayerBullet",
  setup: (player) ->
    @color("#5eb95e")
    @attr
      x: player.x + player.w / 2 - @w / 2
      y: player.y - player.h / 2 + @h / 2
      rotation: player.rotation
      xspeed: 20 * Math.sin(player.rotation / (180 / Math.PI))
      yspeed: 20 * Math.cos(player.rotation / (180 / Math.PI))
    @bind "EnterFrame", ->
      @attr {x: @x + @xspeed, y: @y - @yspeed}
    return this

Crafty.c "FighterBullet",
  dmg: 2
  init: ->
    @requires("Bullet")
      .color("red")
      .attr({h: 5, w: 2})
      .bind "EnterFrame", ->
        @attr {x: @x - @xspeed, y: @y + @yspeed}

Crafty.c "FighterBullets",
  init: ->
    @bullets = []
    @bullets.push(Crafty.e("FighterBullet"))
    @bullets.push(Crafty.e("FighterBullet"))
    return this
  setup: (ship) ->
    i = 0
    for bullet in @bullets
      bullet.attr
        y: ship.y + ship.h / 2 + bullet.h / 2
        rotation: ship.rotation
        xspeed: 10 * Math.sin(ship.rotation / (180 / Math.PI))
        yspeed: 10 * Math.cos(ship.rotation / (180 / Math.PI))
      if i == 0
        bullet.attr({x: ship.x + 8})
      else
        bullet.attr({x: ship.x + ship.w - 8})
      i++
    return this
