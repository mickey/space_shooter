Crafty.c "RandomDamage"
  init: ->
    random_damage = Crafty.math.randomInt 1, 2
    random_damage = "damages_#{random_damage}"
    @addComponent("2D","Canvas",random_damage,"SpriteAnimation")
      .animate(random_damage,[[0,0], [0,1], [0,2], [0, 3], [0,4]])
      .animate(random_damage, 15, 0)
      .bind "AnimationEnd", ->
        @destroy()