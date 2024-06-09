# Include modules and add methods that are for all API requests
abstract class ApiAction < Lucky::Action
  # APIs typically do not need to send cookie/session data.
  # Remove this line if you want to send cookies in the response header.
  disable_cookies
  accepted_formats [:json]

  include Api::Auth::Auth0Helpers
  include Api::Auth::RequireAuth0Token

  # By default all actions are required to use underscores to separate words.
  # Add 'include Lucky::SkipRouteStyleCheck' to your actions if you wish to ignore this check for specific routes.
  # include Lucky::EnforceUnderscoredRoute
  include Lucky::SkipRouteStyleCheck
  include Api::Custom::FilterMacros
  include Api::Custom::Bulk

  include Lucky::Paginator::BackendHelpers

  def paginater_per_page : Int32
    params.get?(:perPage).try(&.to_i) || 20
  end
end
