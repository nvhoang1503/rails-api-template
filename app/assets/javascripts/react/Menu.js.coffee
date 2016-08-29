{ div, a, i, span, label, input  } = React.DOM

window.Menu = React.createClass
  getInitialState: ->
    {
      user_session: {}
    }

  componentWillMount: ->
    MenuStore.listen(@onChange)
    MenuActions.initData(@props)

  componentWillUnmount: ->
    MenuStore.unlisten(@onChange)

  onChange: (state)->
    @setState(state)

  componentDidMount: ->
    menuTag = $(this.refs.menu)
    menuTag.find('.dropdown').dropdown()

  render: ->
    div className: 'ui menu', ref: 'menu',
      a className: 'item', 'Test 1'
      div className: 'ui dropdown item right', tabIndex: '0', 'Account',
        i className: 'dropdown icon'
        div className: 'menu transition hidden', tabIndex: '-1',
          a className: 'item', href: '#', 'Sign out'
