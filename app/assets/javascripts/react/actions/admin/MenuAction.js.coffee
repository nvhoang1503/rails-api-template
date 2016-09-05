class MenuActions
  constructor: ->
    @generateActions(
      'initData'
    )

namespace 'SATV.Admin', (exports) ->
  exports.MenuActions = alt.createActions(MenuActions)
