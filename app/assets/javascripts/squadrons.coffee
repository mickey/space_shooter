Crafty.c "TopFighterSquadron",
  init: ->
    fighter = Crafty.e("Enemy, Fighter")
    if fighter.x + 128 + fighter.w > Crafty.viewport.width
      Crafty.e("Enemy, Fighter").attr({x: fighter.x - 128})
    else
      Crafty.e("Enemy, Fighter").attr({x: fighter.x + 128})
