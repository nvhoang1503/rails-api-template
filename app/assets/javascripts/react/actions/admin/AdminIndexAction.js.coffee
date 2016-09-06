class AdminIndexActions
  constructor: ->
    @generateActions(
      'initData',
      'updateAdmins',
      'updatePageInfo',
      'updateFormMessage'
    )

namespace 'SATV.Admin', (exports) ->
  exports.AdminIndexActions = alt.createActions(AdminIndexActions)
