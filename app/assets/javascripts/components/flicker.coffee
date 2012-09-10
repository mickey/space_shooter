Crafty.c "Flicker",
  flicker: true,
  init: ->
    @flicker = true
    @bind "EnterFrame", (frame) ->
      @alpha = 1.0 if !@flicker
      if frame.frame % 5 == 0 && @flicker
        if @alpha == 0.0
          @alpha = 1.0
        else
          @alpha = 0.0