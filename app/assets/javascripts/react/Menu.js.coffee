{ div, a, i, span, label, input  } = React.DOM

window.Menu = React.createClass
  getInitialState: ->
    items: []

  componentDidMount: ->
    menuTag = $(this.refs.menu)
    menuTag.find('.dropdown').dropdown()

  render: ->
    div className: 'ui menu', ref: 'menu',
      a className: 'item', 'Test 1'
      div className: 'ui dropdown item', tabIndex: '0', 'Test 2',
        i className: 'dropdown icon'
        div className: 'menu transition hidden', tabIndex: '-1',
          a className: 'item', 'Test 3'
          a className: 'item', 'Test 4'
