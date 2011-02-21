class ApiController < ApplicationController
  def status
    # check for vailidity
    begin
      @app_config = APP_CONFIG
      if request.env['HTTP_X_TWITTER_ID'].nil? || request.env['HTTP_X_TWITTER_TOKEN'].nil?
        render :text=>{:status=>"error", :message=>"you must include X_TWITTER_ID and X_TWITTER_TOKEN in your HTTP headers"}.to_json, :status=>403
        return
      end

      # get the id
      id = request.env['HTTP_X_TWITTER_ID']
      # check to make sure the secret token is what it should be
      user = User.find_by_twitter_id(id)
      if user.access_token != request.env['HTTP_X_TWITTER_TOKEN']
        render :text=>{:status=>"error", :message=>"token supplied does not match token on record for this id :#{id}"}.to_json, :status=>403
        return
      end
      # tweet out
      body = request.body.read
      begin
        tweet_response = user.twitter.post('/statuses/update.json', 'status'=>body)
      rescue => e
        render :text=>{:status=>"error", :message=>e.message}.to_json,:status => 503
        return
      end

      # respond with the status id
      render :text=>{:status=>"success", :message=>"tweeted", :url=>"http://twitter.com/#{user.login}/statuses/#{tweet_response['id']}"}.to_json
      return

    rescue => e
      render :text=>{:status=>"error", :message=>e.message}.to_json,:status => 503
    end

  end
end
