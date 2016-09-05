class AdminIndexActions
  constructor: ->
    @generateActions(
      'initData',
      'updateAdmins',
      'updatePageInfo'
    )

namespace 'SATV.Admin', (exports) ->
  exports.AdminIndexActions = alt.createActions(AdminIndexActions)
