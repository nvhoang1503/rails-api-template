class AdminIndexStore
  @displayName: 'AdminIndexStore'

  constructor: ->
    @bindActions(AdminIndexActions)
    @admins = []
    @pageInfo = {}

    @exportPublicMethods(
      {
        getAdmin: @getAdmins
      }
    )

  onInitData: (props)->
    @admins = props.admins
    @pageInfo = props.pageInfo

  onUpdateAdmins: (admins) ->
    @admins.splice(0, @admins.length)
    _.map admins, (admin) =>  
      @admins.push(admin)

  onUpdatePageInfo: (pageInfo) ->
    @pageInfo = pageInfo

  getAdmins: ()->
    @getState().admins

window.AdminIndexStore = alt.createStore(AdminIndexStore)
