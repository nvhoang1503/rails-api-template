namespace 'SATV.Admin', (exports) ->
  class exports.AdminsService
    fetchAdmins: (page)->
      $.ajax
        type: "GET"
        url: Routes.admin_admins_path(page: page)
        success: (data)->
          SATV.Admin.AdminIndexActions.updateAdmins(data.data)
          SATV.Admin.AdminIndexActions.updatePageInfo(data.pageInfo)
        error: (data)->
          console.log("Request data error")

