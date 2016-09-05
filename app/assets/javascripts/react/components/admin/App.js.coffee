{ div, a, i, span, label, input  } = React.DOM

Router = React.createFactory ReactRouter.Router
Route = React.createFactory ReactRouter.Route
IndexRoute = React.createFactory ReactRouter.IndexRoute
hashHistory = ReactRouter.hashHistory 


namespace 'SATV.Admin', (exports) ->
  exports.App = React.createClass
    render: ->
      Router {history: hashHistory},
        Route path: '/', component: ReactRouter.withRouter(SATV.Admin.Layout),
          IndexRoute component: SATV.Admin.Dashboard
          Route path: '/dashboard', component: SATV.Admin.Dashboard
          Route path: '/admins', component: ReactRouter.withRouter(SATV.Admin.AdminIndex)

