class AdminIndexStore
  @displayName: 'AdminIndexStore'

  constructor: ->
    @bindActions(SATV.Admin.AdminIndexActions)
    @admins = []
    @pageInfo = {}
    @form_messages = []

    @exportPublicMethods(
      {
        getAdmins: @getAdmins
      }
    )

  onInitData: (props)->
    @admins = props.admins || []
    @pageInfo = props.pageInfo || {}
    @form_messages = props.form_messages ||  []

  onUpdateAdmins: (admins) ->
    @admins.splice(0, @admins.length)
    _.map admins, (admin) =>  
      @admins.push(admin)

  onUpdatePageInfo: (pageInfo) ->
    @pageInfo = pageInfo

  onUpdateFormMessage: (props)->
    @form_messages = _.map props.messages, (message, index) =>  
      $.extend({}, message,  {id: index} )

  getAdmins: ()->
    @getState().admins

namespace 'SATV.Admin', (exports) ->
  exports.AdminIndexStore = alt.createStore(AdminIndexStore)

