namespace 'SATV.Admin', (exports) ->
  class exports.AdminsService
    createAdmin: (admin)->
      $.ajax
        type: "POST"
        url: Routes.admin_admins_path()
        data: {
          admin: admin
        }
        success: (data)->
          SATV.Admin.AdminNewActions.updateFormMessage(data)
        error: (data)->
          console.log("Request data error")
      
    fetchAdmins: (page)->
      $.ajax
        type: "GET"
        url: Routes.admin_admins_path(page: page)
        success: (data)->
          SATV.Admin.AdminIndexActions.updateAdmins(data.data)
          SATV.Admin.AdminIndexActions.updatePageInfo(data.pageInfo)
        error: (data)->
          console.log("Request data error")

