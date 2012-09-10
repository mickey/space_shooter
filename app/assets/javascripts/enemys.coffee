Crafty.c "Fighter",
  hitDmg: 10
  shootingSpeed: 30
  init: ->
    @shootingSpeed = @shootingSpeed + Crafty.math.randomInt(10, 30)
    @requires("ships_Mmrnmhrm_start_screen_8")
    .attr({x: Crafty.math.randomInt(@w, Crafty.viewport.width - @w)})
    .bind "EnterFrame", (frame) ->
      @y += 4
      if frame.frame % @shootingSpeed == 0
        Crafty.e("FighterBullets").setup(this)


Crafty.c "Kamikaze",
  hitDmg: 25
  init: ->
    attacking = false
    player = Crafty(Crafty("Player")[0])
    @requires("ships_Mycon_start_screen_8")
    .attr({x: Crafty.math.randomInt(@w + Crafty.viewport.width/5, Crafty.viewport.width - Crafty.viewport.width/5)})
    .bind "EnterFrame", (frame) ->
      @y += 2 if @y < 0
      @x += 4 if @x < player.x && !attacking
      @x -= 4 if @x > player.x && !attacking
      attacking = true if @x == player.x
      if attacking
        @y += 20
      else
        @y += 15

Crafty.c "Enemy",
  init: ->
    @requires("2D,Canvas,Collision")
    .origin("center")
    .attr({y:-@h-50, z: 50})
    .onHit "PlayerBullet", (ent) ->
      bullet = ent[0].obj
      #@trigger "Hurt", bullet.dmg
      @trigger "Hurt", 1000
      bullet.destroy()
    .bind "Hurt", (dmg) ->
      # blahblah damage
      @trigger("Die")
    .bind "Die", () ->
      Crafty.e("RandomExplosion").attr({
        x: @x - @w/2,
        y: @y - @h/2,
        z: 50
      })
      @destroy()
    .bind "EnterFrame", (frame) ->
      @screenLimits()
  screenLimits: ->
    if @x > Crafty.viewport.width + @w ||
      @x < -@w ||
      @y < -@h ||
      @y > Crafty.viewport.height + @h
        @destroy()