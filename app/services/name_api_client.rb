class NameApiClient
  def get_name(_user)
    puts 'Fetching name from remote API'
    'DVDB'
  end

  def valid_name?(_name)
    puts 'Calling remote API in validation'
    false
  end
end
