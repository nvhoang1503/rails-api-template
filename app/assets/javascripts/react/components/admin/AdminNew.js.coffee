{ div, form, label, input, button} = React.DOM

namespace 'SATV.Admin', (exports) ->
  exports.AdminNew = React.createClass
    getInitialState: ->
      {
      }
    render: ->
      div className: 'admin-page-new',
        form className: 'ui form',
          div className: 'field',
            label {}, "Email"
            input {type: "text", name: "admin[email]", placeholder: "email"}
          div className: 'field',
            label {}, "Password"
            input {type: "text", name: "admin[password]", placeholder: "password"}
          div className: 'field',
            label {}, "Password confirmation"
            input {type: "text", name: "admin[password_confirmation]", placeholder: "password confirmation"}
          button className: 'ui button', "Save"
            

  
