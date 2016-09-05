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
    @messages = _.map props.messages, (message) =>  
      $.extend({}, message,  {id: _.now()} )

  getAdmin: ()->
    @getState().admin

namespace 'SATV.Admin', (exports) ->
  exports.AdminNewStore = alt.createStore(AdminNewStore)
