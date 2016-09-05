class MenuStore
  @displayName: 'MenuStore'

  constructor: ->
    @bindActions(SATV.Admin.MenuActions)
    @userSession = {}

    @exportPublicMethods(
      {
        getUserSession: @getUserSession
      }
    )

  onInitData: (props)->
    @userSession = props.userSession


  getUserSession: ()->
    @getState().userSession

namespace 'SATV.Admin', (exports) ->
  exports.MenuStore = alt.createStore(MenuStore)
