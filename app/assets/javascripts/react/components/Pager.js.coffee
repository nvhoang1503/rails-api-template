# Paging component for lists
{ div, table, thead, tr, th, tbody, td, tfoot, a, i } = React.DOM

window.Pager = React.createFactory React.createClass
  getDefaultProps: ->
    {
      totalPages: 11,
      currentPage: 1,
      windowSize: 3
    }

  totalSegments: ->
    Math.ceil(parseFloat(@props.totalPages) / parseFloat(@props.windowSize))

  currentSegment: ->
    Math.ceil(parseFloat(@props.currentPage) / parseFloat(@props.windowSize))

  isFirstSegment: ->
    if @currentSegment() == 1
      return true
    return false

  isLastSegment: ->
    if @currentSegment() < @totalSegments()
      return false
    return true

  minWindow: ->
    (@currentSegment() - 1) * parseInt(@props.windowSize) + 1

  maxWindow: ->
    if !@isLastSegment()
      return @currentSegment() * parseInt(@props.windowSize)
    return @props.totalPages

  isActivePage: (page) ->
    if parseInt(page) == parseInt(@props.currentPage)
      return true
    return false

  handleClick: (e) ->
    if (typeof $(e.target).data('page') != 'undefined')
      nextCurrentPage = parseInt($(e.target).data('page'))
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
