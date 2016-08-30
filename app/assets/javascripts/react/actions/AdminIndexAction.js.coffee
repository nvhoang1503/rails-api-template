class AdminIndexActions
  constructor: ->
    @generateActions(
      'initData',
      'updateAdmins',
      'updatePageInfo'
    )

window.AdminIndexActions = alt.createActions(AdminIndexActions)
