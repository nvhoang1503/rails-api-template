# Messages when user interacts with the forms
{ div, p } = React.DOM

window.FormMessageItem = React.createFactory React.createClass
  getDefaultProps: ->
    {
      content: "",
      type: "error",
    }
  render: ->
    div className: 'ui error message',
      p {}, @props.content
