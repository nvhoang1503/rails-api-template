{ div, a, i, span, label, input  } = React.DOM

namespace 'SATV.Admin', (exports) ->
  exports.Layout = React.createClass
    componentWillMount: ->
      SATV.Admin.RouterStore.listen(@onChange)
      SATV.Admin.RouterActions.initData(@props)
      SATV.Admin.RouterActions.updateRouteData({
        query: @props.location.query
        pathname: @props.location.pathname,
        state: @props.location.state
      })
  
      SATV.Admin.RouterActions.updateMainRouter(@props.router)
  
      @props.router.listen(@browserHistoryChanged)
  
    browserHistoryChanged: (ev)->
      SATV.Admin.RouterActions.updateRouteData({
        query: ev.query
        pathname: ev.pathname,
        state: ev.state
      })
  
    componentWillUnmount: ->
      Store.unlisten(@onChange)
      @props.router.unregisterTransitionHook(@browserHistoryChanged)
  
    onChange: (state)->
      # console.log('state changed')
      # console.log(state.routeData)
      @setState(state)
  
    render: ->
      div {},
        @props.children
