{ div, a, i, span, label, input  } = React.DOM
Link = React.createFactory ReactRouter.Link


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
      MenuReactItem href: '/', "Dashboard"
      MenuDropDown {text: "Accounts", align: 'left'},
        MenuReactItem href: '/admins', "Admins"
      MenuDropDown {text: "User", align: 'right'},
        MenuItem href: @props.user_session.logout_path, method: 'delete', 'Sign out'

MenuDropDown = React.createFactory React.createClass
  getDefaultProps: ->
    {
      text: 'untitled'
      align: ''
    }
  render: ->
    div className: 'ui dropdown item '+ @props.align, tabIndex: '0', @props.text,
      i className: 'dropdown icon'
      div className: 'menu transition hidden', tabIndex: '-1', @props.children

MenuReactItem = React.createFactory React.createClass
  getDefaultProps: ->
    {
      href: '#'
    }

  onClick: (event)->
    event.preventDefault()

    RouterStore.getMainRouter().push({
      query: {},
      pathname: @props.href
    })
    
  render: ->
    # Link className: 'item', to: @props.href, @props.children
    a className: 'item', href: @props.href, onClick: @onClick, @props.children

MenuItem = React.createFactory React.createClass
  getDefaultProps: ->
    {
      href: '#',
      method: ''
      remote: 'false'
    }
  render: ->
    a className: 'item', href: @props.href, 'data-method': @props.method, 'data-remote': @props.remote, @props.children
