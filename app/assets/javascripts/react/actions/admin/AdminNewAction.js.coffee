class AdminNewActions
  constructor: ->
    @generateActions(
      'initData',
      'updateMessage'
    )

  create: (admin)->
    adminsService = new SATV.Admin.AdminsService
    adminsService.createAdmin(admin)
    return admin

namespace 'SATV.Admin', (exports) ->
  exports.AdminNewActions = alt.createActions(AdminNewActions)
