class MenuActions
  constructor: ->
    @generateActions(
      'initData'
    )

window.MenuActions = alt.createActions(MenuActions)
