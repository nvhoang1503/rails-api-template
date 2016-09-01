class RouterActions
  constructor: ->
    @generateActions(
      'initData',
      'updateRouteData',
      'updateQuery',
      'updatePathname',
      'updateState',
      'updateMainRouter'
    )

window.RouterActions = alt.createActions(RouterActions)
