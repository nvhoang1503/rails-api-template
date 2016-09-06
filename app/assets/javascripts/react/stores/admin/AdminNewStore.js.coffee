class AdminNewStore
  @displayName: 'AdminNewStore'

  constructor: ->
    @bindActions(SATV.Admin.AdminNewActions)
    @admin = {}
    @form_messages = []

    @exportPublicMethods(
      {
        getAdmin: @getAdmin
      }
    )

  onInitData: (props)->
    @admin = props.admin || {}
    @form_messages = props.form_messages ||  []

  onCreate: (props)->
    @admin = props

  onUpdateFormMessage: (props)->
    @form_messages = _.map props.messages, (message, index) =>  
      $.extend({}, message,  {id: index} )

  getAdmin: ()->
    @getState().admin

namespace 'SATV.Admin', (exports) ->
  exports.AdminNewStore = alt.createStore(AdminNewStore)
