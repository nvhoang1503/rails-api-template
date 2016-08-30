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
            Pager({onPageChanged: (data)->
              alert(data.currentPage)
            })

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

  handleClick: (e) ->
    nextCurrentPage = $(e.target).data('page')
    if (typeof @props.onPageChanged != 'undefined')
      @props.onPageChanged({currentPage: nextCurrentPage})

  render: ->
    div className: 'ui right floated pagination menu',
      a className: 'icon item item__first-page-btn', 'data-page': 1, key: 'first-page-1', onClick: @handleClick,
       i className: 'left step backward icon'
      if !@isFirstSegment()
        a className: 'item item__previous-segment-btn', 'data-page': @minWindow() - 1, key: 'previous-segment-'+ (@minWindow() - 1), onClick: @handleClick, '...' 
      _.map _.range(@minWindow(), @maxWindow() + 1), (index) =>
        if @isActivePage(index)
          a className: 'item active item__page-btn'+' page-'+index, 'data-page': index, key: index, onClick: @handleClick, index
        else
          a className: 'item item__page-btn'+' page-'+index, 'data-page': index, key: index, onClick: @handleClick, index
      if !@isLastSegment()
        a className: 'item item__next-segment-btn', 'data-page': @maxWindow() + 1, key: 'next-segment-'+ (@maxWindow() + 1), onClick: @handleClick, '...' 
      a className: 'icon item item__last-page-btn', 'data-page': @props.totalPages, key: 'last-page-'+ (@props.totalPages), onClick: @handleClick,
       i className: 'right step forward icon'
