class AdminIndexStore
  @displayName: 'AdminIndexStore'

  constructor: ->
    @bindActions(SATV.Admin.AdminIndexActions)
    @admins = []
    @pageInfo = {}

    @exportPublicMethods(
      {
        getAdmins: @getAdmins
      }
    )

  onInitData: (props)->
    @admins = props.admins || []
    @pageInfo = props.pageInfo || {}

  onUpdateAdmins: (admins) ->
    @admins.splice(0, @admins.length)
    _.map admins, (admin) =>  
      @admins.push(admin)

  onUpdatePageInfo: (pageInfo) ->
    @pageInfo = pageInfo

  getAdmins: ()->
    @getState().admins

namespace 'SATV.Admin', (exports) ->
  exports.AdminIndexStore = alt.createStore(AdminIndexStore)

