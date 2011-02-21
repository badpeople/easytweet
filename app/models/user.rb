class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.

  def friends_ids(page=0)
    self.twitter.get('/friends/ids.json')
  end
end
