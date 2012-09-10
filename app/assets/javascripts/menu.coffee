class Menu
  constructor: (@scope, select) ->

    # Menu mouse control
    $("##{@scope} .controls .button").hover(
      () ->
        $("##{@scope} .controls .button").removeClass("hover")
        $(this).addClass("hover")
      () -> $(this).removeClass("hover")
    )

    $("##{@scope} .controls .button").click ->
      select $(this).html()

    key.setScope @scope

    key 'enter', @scope, ->
      select $("##{@scope} .controls .button.hover").html()

    key 'down', @scope, ->
      current_hover = $("##{@scope} .controls .button.hover")
      current_hover.removeClass("hover")
      if (current_hover.next(".button").length > 0)
        current_hover.next(".button").addClass("hover")
      else
        $("##{@scope} .controls .button").first().addClass("hover")

    key 'up', @scope, ->
      current_hover = $("##{@scope} .controls .button.hover")
      current_hover.removeClass("hover")
      if (current_hover.prev(".button").length > 0)
        current_hover.prev(".button").addClass("hover")
      else
        $("##{@scope} .controls .button").last().addClass("hover")

window.Menu = Menu