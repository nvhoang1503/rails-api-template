{ div, table, thead, tr, th, tbody, td, tfoot, a, i } = React.DOM

namespace 'SATV.Admin', (exports) ->
  exports.AdminIndex = React.createClass
    getInitialState: ->
      {
        admins: [],
        pageInfo: {}
      }
  
    componentWillMount: ->
      SATV.Admin.AdminIndexStore.listen(@onChange)
      SATV.Admin.AdminIndexActions.initData(@props)
      SATV.Admin.RouterStore.listen(@onUrlChange)
  
      page = SATV.Admin.RouterStore.getRouteData().query.page
      adminsService = new SATV.Admin.AdminsService
      adminsService.fetchAdmins(page)
  
    componentWillUnmount: ->
      SATV.Admin.AdminIndexStore.unlisten(@onChange)
  
    onChange: (state)->
      @setState(state)
  
    onUrlChange: (state)->
      adminService = new SATV.Admin.AdminsService
      adminService.fetchAdmins(state.routeData.query.page || 1)
  
  
    onPageChanged: (data)->
      query = SATV.Admin.RouterStore.getRouteData().query
      pathname = SATV.Admin.RouterStore.getRouteData().pathname
      state = SATV.Admin.RouterStore.getRouteData().state
  
      SATV.Admin.RouterStore.getMainRouter().push({
        query: $.extend({}, query, {page: data.currentPage}),
        pathname: pathname,
        state: state
      })
  
    render: ->
      div className: 'admin-page',
        table className: 'ui celled table',
          thead {},
            tr {},
              th {}, 'Id'
              th {}, 'Email'
              th {}, 'Created at'
          tbody {},
            _.map @state.admins, (admin) =>  
              tr {key: admin.id},
                td {}, admin.id
                td {}, admin.email
                td {}, admin.created_at
          tfoot {},
            tr {},
              th colSpan: '3',
                Pager($.extend({}, @state.pageInfo, {onPageChanged: @onPageChanged}))
  
