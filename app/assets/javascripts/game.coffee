# deactivates logger for production code
# debug = {}
# debug.error = ->
# debug.warn = ->
# debug.info = ->
# debug.debug = ->
# debug.log = ->

$(document).ready ->
  Crafty.init()
  Crafty.canvas.init()
  # Set canvas under interface
  Crafty.canvas._canvas.style.zIndex = '1'
  # play the loading scene
  Crafty.scene("Loading")