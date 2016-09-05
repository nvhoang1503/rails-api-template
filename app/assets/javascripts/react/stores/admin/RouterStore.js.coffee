class RouterStore
  @displayName: 'RouterStore'

  constructor: ->
    @bindActions(SATV.Admin.RouterActions)
    @routeData = {
      query: {},
      pathname: {},
      state: {}
    }
    @mainRouter = {}

    @exportPublicMethods(
      {
        getRouteData: @getRouteData,
        getMainRouter: @getMainRouter
      }
    )

  onInitData: (props)->
    @routeData = props.routeData || {}

  onUpdateRouteData: (routeData)->
    @routeData =  routeData
    
  onUpdateMainRouter: (mainRouter)->
    @mainRouter =  mainRouter

  onUpdateQuery: (query)->
    if typeof @routeData == 'undefined'
      @routeData = {}
    @routeData.query = query

  onUpdatePathname: (pathname)->
    if typeof @routeData == 'undefined'
      @routeData = {}
    @routeData.pathname = pathname

  onUpdateState: (state)->
    if typeof @routeData == 'undefined'
      @routeData = {}
    @routeData.state = state

  getRouteData: ()->
    @getState().routeData

  getMainRouter: ()->
    @getState().mainRouter

  getQuery: ()->
    @getState().routeData.query

  getPathName: ()->
    @getState().routeData.pathName

  getState: ()->
    @getState().routeData.state

namespace 'SATV.Admin', (exports) ->
  exports.RouterStore = alt.createStore(RouterStore)
