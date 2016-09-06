class AdminNewActions
  constructor: ->
    @generateActions(
      'initData',
      'updateFormMessage'
    )

  create: (admin)->
    adminsService = new SATV.Admin.AdminsService
    adminsService.createAdmin(admin)
    return admin

namespace 'SATV.Admin', (exports) ->
  exports.AdminNewActions = alt.createActions(AdminNewActions)
