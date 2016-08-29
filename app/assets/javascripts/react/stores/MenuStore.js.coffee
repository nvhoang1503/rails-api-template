class MenuStore
  @displayName: 'MenuStore'

  constructor: ->
    @bindActions(MenuActions)
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

window.MenuStore = alt.createStore(MenuStore)
