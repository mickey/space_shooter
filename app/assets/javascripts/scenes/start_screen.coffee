Crafty.scene "StartScreen", ->

  $('#menu').show();
  new Menu "menu", (option) ->
    if option == "Start"
      key.deleteScope 'menu'
      $("#menu").hide()
      Crafty.scene "Level1"