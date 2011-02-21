require "spec_helper"
require "rspec"

describe "Db Setup" do

  it "should be able to save" do

    #To change this template use File | Settings | File Templates.
    user = User.new_from_twitter_hash({:login=>"mylogin",'id'=>11111111,'screen_name'=>"mylogin"})
    res = user.save
    res.should == true
  end
end