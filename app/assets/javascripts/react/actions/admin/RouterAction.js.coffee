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

namespace 'SATV.Admin', (exports) ->
  exports.RouterActions = alt.createActions(RouterActions)
