module ApplicationHelper
	def ensure_json_request
		return if request.format == :json
			raise ActionController::RoutingError.new('Not Found')
		end
end
