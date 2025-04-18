module ApplicationHelper
  def algolia_credentials
    credentials = {
      app_id: ENV["ALGOLIA_APPLICATION_ID"],
      api_key: ENV["ALGOLIA_API_KEY"]
    }
    credentials.to_json.gsub('"', "&quot;").html_safe
  end
end
