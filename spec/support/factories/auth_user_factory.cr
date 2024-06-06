class AuthUserFactory < Avram::Factory
  def initialize
    password ""
    is_superuser false
    username "#{ENV["AUTH0_TEST_USER_CLIENT_ID"]}@clients"
    first_name ""
    last_name ""
    email ""
    is_staff false
    is_active true
    date_joined Time.local
  end
end
