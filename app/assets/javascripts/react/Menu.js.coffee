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
      MenuItem href: Routes.admin_home_dashboard_path(), method: 'get', remote: true, "Dashboard"
      MenuDropDown {text: "Accounts", align: 'left'},
        MenuItem href: Routes.admin_home_admins_path(), method: 'get', remote: true, "Admins"
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

MenuItem = React.createFactory React.createClass
  getDefaultProps: ->
    {
      href: '#',
      method: ''
      remote: 'false'
    }
  render: ->
    a className: 'item', href: @props.href, 'data-method': @props.method, 'data-remote': @props.remote, @props.children
