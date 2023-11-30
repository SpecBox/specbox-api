module Api::Auth::SkipRequireAuth0Token
  macro included
    skip require_auth_token
  end

  # Since sign in is not required, current_user might be nil
  def current_user : AuthUser?
    current_user?
  end
end
