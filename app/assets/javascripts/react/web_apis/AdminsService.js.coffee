namespace 'SATV.Admin', (exports) ->
  class exports.AdminsService
    fetchAdmins: (page)->
      $.ajax
        type: "GET"
        url: Routes.admin_admins_path(page: page)
        success: (data)->
          AdminIndexActions.updateAdmins(data.data)
          AdminIndexActions.updatePageInfo(data.pageInfo)
        error: (data)->
          console.log("Request data error")

