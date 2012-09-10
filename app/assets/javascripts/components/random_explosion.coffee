Crafty.c "RandomExplosion"
  init: ->
    random_explosion = Crafty.math.randomInt 1, 11
    random_explosion = "explosions_#{random_explosion}"
    @addComponent("2D","Canvas",random_explosion,"SpriteAnimation")
      .animate(random_explosion,[[0,0], [0,1], [0,2], [0, 3], [0,4]])
      .animate(random_explosion, 15, 0)
      .bind "AnimationEnd", ->
        @destroy()