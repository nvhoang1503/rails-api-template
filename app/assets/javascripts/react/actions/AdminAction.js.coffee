class AdminIndexActions
  constructor: ->
    @generateActions(
      'initData'
    )

window.AdminIndexActions = alt.createActions(AdminIndexActions)
