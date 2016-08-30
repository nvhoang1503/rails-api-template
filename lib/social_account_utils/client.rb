require 'open-uri'
class SocialAccountUtils::Client
  def initialize(params)
    @access_token = params[:access_token]
    @provider = params[:provider]
    @is_connected = false
    get_auth_object
  end

  def connected?
    @is_connected
  end

  def auth_object
    @auth_object
  end

  def uid
    @auth_object.try(:identifier) ||  @auth_object.try("[]", "id")
  end

  def first_name
    @auth_object.try(:first_name) || @auth_object.try("[]", "given_name")
  end

  def last_name
    @auth_object.try(:last_name) || @auth_object.try("[]", "family_name")
  end

  def email
    @auth_object.try(:email) || @auth_object.try("[]", "email")
  end

  def avatar
    @auth_object.try(:picture).try(:concat, "?width=300") || @auth_object.try("[]", "picture")
  end

  private 

  def get_auth_object
    case @provider
    when "facebook"
      begin
        @auth_object = FbGraph::User.me(@access_token).fetch(:fields => "first_name, last_name, email")
        @is_connected = true
      rescue Exception => e
        Rails.logger.info "Facebook access token is not valid"
        return nil
      end
    when "google"
      begin
        result = JSON.parse Net::HTTP.get(URI.parse("https://www.googleapis.com/oauth2/v2/userinfo?alt=json&access_token=#{@access_token}"))
        if result.try("[]", "error") == nil
          @auth_object = result
          @is_connected = true
          return
        end
        @auth_object = nil
      rescue Exception => e
        Rails.logger.info "Google access token is not valid"
        return nil
      end
    end
  end

end