class NameApiClient
  def get_name(_user)
    puts 'Fetching name from remote API'
    'DVDB'
  end

  def valid_name?(name)
    puts 'calling remote api in validation'
    false
  end
end
