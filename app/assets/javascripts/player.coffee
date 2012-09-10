Crafty.c "Player",
  movementSpeed: 11
  isLoading: true
  health: 100
  init: ->
    keyDown = false
    @update_health()
    @requires("2D, Canvas, ships_Shofixti_start_screen_0, Fourway, Flicker, Keyboard, Collision")
      .attr
        x: Crafty.viewport.width/2 - @w/2
        y: Crafty.viewport.height - @h - 5
        z: 50
      .fourway(@movementSpeed)
      .bind 'Moved', (from) ->
        # Dont allow to move the player out of Screen
        @screenLimits(from)
      .bind "KeyDown", (e) ->
        keyDown = true if e.keyCode == Crafty.keys.SPACE
      .bind "KeyUp", (e) ->
        keyDown = false if e.keyCode == Crafty.keys.SPACE
      .bind "EnterFrame", (frame) ->
        @loadingAnim() if @isLoading
        if keyDown && frame.frame % 10 == 0
          @shoot()
        @isPlaying
      .bind "Hurt", (dmg) ->
        @health -= dmg
        Crafty.e("RandomDamage").attr({
          x: @x - @w/2,
          y: @y - @h/2,
          z: 100
        })
        if @health <= 0
          @health = 0
          @trigger "Die"
        @update_health()
      .bind "Die", () ->
        Crafty.e("RandomExplosion").attr({
          x: @x - @w/2,
          y: @y - @h/2,
          z: 50
        })
        @destroy()
        @gameOver()
      .onHit "Enemy", (ent) ->
        enemy = ent[0].obj
        @trigger "Hurt", enemy.hitDmg
        enemy.trigger "Die"
      .onHit "Bullet", (ent) ->
        bullet = ent[0].obj
        @trigger "Hurt", bullet.dmg
        bullet.destroy()
  loadingAnim: ->
    @y--
    if @y < Crafty.viewport.height - @h - Crafty.viewport.height/10
      @isLoading = false
      @flicker = false
  screenLimits: (from) ->
    if @x + @w > Crafty.viewport.width ||
      @x + @w < @w ||
      @y + @h - 10 < @h ||
      @y + @h + 10 > Crafty.viewport.height || @isLoading
        @attr {x: from.x, y: from.y}
  shoot: () ->
    Crafty.e("Bullet", "PlayerBullet").setup(this)
  update_health: () ->
    $("#life .bar").html(@health).css("width", "#{@health}%")
    if @health <= 50 && @health > 20
      $("#life .progress").removeClass("progress-danger")
      $("#life .progress").removeClass("progress-success")
      $("#life .progress").addClass("progress-warning")
    else if @health <= 20
      $("#life .progress").removeClass("progress-success")
      $("#life .progress").removeClass("progress-warning")
      $("#life .progress").addClass("progress-danger")
    else
      $("#life .progress").removeClass("progress-danger")
      $("#life .progress").removeClass("progress-warning")
      $("#life .progress").addClass("progress-success")
  gameOver: () ->
    $("#game_over").show()
    new Menu "game_over", (option) ->
      if option == "Restart"
        key.deleteScope 'game_over'
        $("#game_over").hide()
        Crafty.scene "Level1"