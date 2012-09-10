Crafty.scene "Loading", ->

  assets = []

  random_bg = "#{Math.floor(Math.random()*7)+1}.jpg"
  assets.push "/assets/backgrounds/baked/#{random_bg}"
  Crafty.background("url(assets/backgrounds/baked/#{random_bg}) black")

  Crafty.bind "EnterFrame", (frame) ->
    Crafty.stage.elem.style.backgroundPosition = "0px #{frame.frame * 2}px"
    # add planet
    # if frame.frame % 1000 == 0
    #   Crafty.e("Planet")

  # planets
  # planets = ["moon", "earth", "mars"]
  # for name in planets
  #   assets.push "/assets/planets/baked/#{name}.png"

  # planets = [1..15]
  # planet_formats = ["tiny", "small", "medium", "big"]
  # for i in planets
  #   for format in ["tiny", "small", "medium", "big"]
  #     name = "#{format}_#{i}"
  #     assets.push "/assets/planets/baked/#{name}.png"


  # ships
  ships = ["Mmrnmhrm", "Shofixti", "Mycon"]
  ship_formats = ["start_screen"]
  # ship_rotations = [0..15]
  ship_rotations = [0, 8]
  for ship in ships
    for rotation in ship_rotations
      for format in ship_formats
        name = "#{format}_#{rotation}"
        assets.push "/assets/ships/baked/#{ship}/#{name}.png"

  explosions = [1..11]
  assets.push "/assets/explosions/#{i}.png" for i in explosions

  damages = [1, 2]
  assets.push "/assets/damages/#{i}.png" for i in damages

  Crafty.load(assets,
    () ->

      # explosions
      for i in explosions
        map = {}
        map["explosions_#{i}"] = [0,0]
        Crafty.sprite(128, "/assets/explosions/#{i}.png", map)

      # explosions
      for i in damages
        map = {}
        map["damages_#{i}"] = [0,0]
        Crafty.sprite(128, "/assets/damages/#{i}.png", map)

      # planets
      # for name in planets
      #   img = new Image()
      #   img.src = "/assets/planets/baked/#{name}.png"
      #   map = {}
      #   map["planets_#{name}"] = [0,0]
      #   Crafty.sprite(img.width, img.height, img.src, map)

      # for i in planets
      #   for type in planet_formats
      #     img = new Image()
      #     name = "#{type}_#{i}"
      #     img.src = "/assets/planets/baked/#{name}.png"
      #     map = {}
      #     map["planets_#{name}"] = [0,0]
      #     Crafty.sprite(img.width, img.height, img.src, map)

      # ships
      for ship in ships
        for rotation in ship_rotations
          for format in ship_formats
            img = new Image()
            name = "#{format}_#{rotation}"
            img.src = "/assets/ships/baked/#{ship}/#{name}.png"
            map = {}
            map["ships_#{ship}_#{name}"] = [0,0]
            Crafty.sprite(img.width, img.height, img.src, map)

      $('#loading').hide();
      Crafty.scene("StartScreen");

    (e) ->
      percent = ~~e.percent
      $("#loading .bar").html(percent).css("width", "#{percent}%")
    (e) ->
      console.log("error")
      console.log(e)
  )