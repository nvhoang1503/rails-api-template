{ div, table, thead, tr, th, tbody, td, tfoot, a, i } = React.DOM

window.AdminIndex = React.createClass
  getInitialState: ->
    {
      admins: []
    }

  componentWillMount: ->
    AdminIndexStore.listen(@onChange)
    AdminIndexActions.initData(@props)

  componentWillUnmount: ->
    AdminIndexStore.unlisten(@onChange)

  onChange: (state)->
    @setState(state)

  render: ->
    table className: 'ui celled table',
      thead {},
        tr {},
          th {}, 'Id'
          th {}, 'Email'
          th {}, 'Created at'
      tbody {},
        _.map @props.admins, (admin) =>  
          tr {key: admin.id},
            td {}, admin.id
            td {}, admin.email
            td {}, admin.created_at
      tfoot {},
        tr {},
          th colSpan: '3',
            Pager()

window.Pager = React.createFactory React.createClass
  getDefaultProps: ->
    {
      totalPages: 11,
      currentPage: 1,
      windowSize: 3
    }

  totalSegments: ->
    Math.ceil(@props.totalPages / @props.windowSize)

  currentSegment: ->
    Math.ceil(@props.currentPage / @props.windowSize)

  isFirstSegment: ->
    if @currentSegment() == 1
      return true
    return false

  isLastSegment: ->
    if @currentSegment() < @totalSegments()
      return false
    return true

  minWindow: ->
    (@currentSegment() - 1) * @props.windowSize + 1

  maxWindow: ->
    if !@isLastSegment()
      return @currentSegment() * @props.windowSize
    return @props.totalPages

  isActivePage: (page) ->
    if page == @props.currentPage
      return true
    return false

  render: ->
    div className: 'ui right floated pagination menu',
      a className: 'icon item item__first-page-btn',
       i className: 'left chevron icon'
      if !@isFirstSegment()
        a className: 'item item__previous-segment-btn', key: 'previous-segment', '...' 
      _.map _.range(@minWindow(), @maxWindow() + 1), (index) =>
        if @isActivePage(index)
          a className: 'item active item__page-btn'+' page-'+index, key: index, index
        else
          a className: 'item item__page-btn'+' page-'+index, key: index, index
      if !@isLastSegment()
        a className: 'item item__next-segment-btn', key: 'next-segment', '...' 
      a className: 'icon item item__last-page-btn',
       i className: 'right chevron icon'
