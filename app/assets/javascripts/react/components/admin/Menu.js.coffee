{ div, a, i, span, label, input  } = React.DOM
Link = React.createFactory ReactRouter.Link

namespace 'SATV.Admin', (exports) ->
  exports.Menu = React.createClass
    getInitialState: ->
      {
        user_session: {},
        current_path_name: "/"
      }
  
    componentWillMount: ->
      SATV.Admin.MenuStore.listen(@onChange)
      SATV.Admin.MenuActions.initData(@props)
  
      SATV.Admin.RouterStore.listen(@onUrlChange)
  
    componentWillUnmount: ->
      SATV.Admin.MenuStore.unlisten(@onChange)
  
      SATV.Admin.RouterStore.unlisten(@onUrlChange)
  
    onChange: (state)->
      @setState(state)
  
    onUrlChange: (state)->
      @setState($.extend({}, @state, {current_path_name: state.routeData.pathname}))
  
    componentDidMount: ->
      menuTag = $(this.refs.menu)
      menuTag.find('.dropdown').dropdown()
  
    render: ->
      div className: 'ui menu', ref: 'menu',
        MenuReactItem {href: '/', current_path_name: @state.current_path_name}, "Dashboard"
        MenuDropDown {text: "Accounts", align: 'left'},
          MenuReactItem {href: '/admins', current_path_name: @state.current_path_name}, "Admins"
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
    getInitialState: ->
      {
        activeClass: ""
      }
  
    componentWillMount: ->
      if @props.href == @props.current_path_name
        @state.activeClass = "active"
      else
        @state.activeClass = ""
  
    componentWillUpdate: (nextProps, nextState)->
      if @props.href == nextProps.current_path_name
        @state.activeClass = "active"
      else
        @state.activeClass = ""
  
    getDefaultProps: ->
      {
        href: '#',
        current_path_name: "/"
      }
  
    onClick: (event)->
      event.preventDefault()
  
      SATV.Admin.RouterStore.getMainRouter().push({
        query: {},
        pathname: @props.href
      })
      
    render: ->
      a className: 'item ' + @state.activeClass, href: @props.href, onClick: @onClick, @props.children
  
  MenuItem = React.createFactory React.createClass
    getDefaultProps: ->
      {
        href: '#',
        method: ''
        remote: 'false'
      }
    render: ->
      a className: 'item', href: @props.href, 'data-method': @props.method, 'data-remote': @props.remote, @props.children
