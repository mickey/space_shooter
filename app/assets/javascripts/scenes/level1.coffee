Crafty.scene("Level1",
  () ->
    $("#game").show()

    key.setScope 'game'

    key 'esc, p', "game", ->
      Crafty.pause()
      $("#pause").toggle()

    player = Crafty.e "Player"

    @do_stuff = (frame) ->
      return if player.isLoading
      if frame.frame % 150 == 0
        Crafty.e("Enemy, Kamikaze")
      if frame.frame % 100 == 0
        Crafty.e("TopFighterSquadron")

    @bind "EnterFrame", @do_stuff
  () ->
    @unbind "EnterFrame", @do_stuff
    key.deleteScope 'game'
)