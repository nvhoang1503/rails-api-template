{ div, a, i, span, label, input  } = React.DOM

window.Layout = React.createClass

  componentWillMount: ->
    RouterStore.listen(@onChange)
    RouterActions.initData(@props)
    RouterActions.updateRouteData({
      query: @props.location.query
      pathname: @props.location.pathname,
      state: @props.location.state
    })

    RouterActions.updateMainRouter(@props.router)

    @props.router.listen(@browserHistoryChanged)

  browserHistoryChanged: (ev)->
    RouterActions.updateRouteData({
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
