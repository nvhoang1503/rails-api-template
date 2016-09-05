class AdminNewStore
  @displayName: 'AdminNewStore'

  constructor: ->
    @bindActions(SATV.Admin.AdminNewActions)
    @admin = {}
    @messages = []

    @exportPublicMethods(
      {
        getAdmin: @getAdmin
      }
    )

  onInitData: (props)->
    @admin = props.admin || {}

  onCreate: (props)->
    @admin = props

  onUpdateMessage: (props)->
    @messages = _.map props.messages, (message, index) =>  
      $.extend({}, message,  {id: index} )

  getAdmin: ()->
    @getState().admin

namespace 'SATV.Admin', (exports) ->
  exports.AdminNewStore = alt.createStore(AdminNewStore)
