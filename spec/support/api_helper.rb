module ApiHelper
  def api_response
    JSON.parse(response.body)
  end
end
