class AdminIndexStore
  @displayName: 'AdminIndexStore'

  constructor: ->
    @bindActions(AdminIndexActions)
    @admins = []

    @exportPublicMethods(
      {
        getAdmin: @getAdmins
      }
    )

  onInitData: (props)->
    @admins = props.admins


  getAdmins: ()->
    @getState().admins

window.AdminIndexStore = alt.createStore(AdminIndexStore)
