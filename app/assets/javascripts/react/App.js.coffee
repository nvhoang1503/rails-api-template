{ div, a, i, span, label, input  } = React.DOM

Router = React.createFactory ReactRouter.Router
Route = React.createFactory ReactRouter.Route
IndexRoute = React.createFactory ReactRouter.IndexRoute
hashHistory = ReactRouter.hashHistory 


window.App = React.createClass
  render: ->
    Router {history: hashHistory},
      Route path: '/', component: ReactRouter.withRouter(Layout),
        IndexRoute component: Dashboard
        Route path: '/dashboard', component: Dashboard
        Route path: '/admins', component: ReactRouter.withRouter(AdminIndex)

