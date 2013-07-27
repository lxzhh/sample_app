# encoding: utf-8
require "uri"
class StaticPagesController < ApplicationController
  def home
    
    
    if signed_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
   end
   @user ||= current_user
  end
  

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  
  def baiduImageIframe(string)
    word = URI::encode(string)
    url = "http://image.baidu.com/i?"
    params = "http://localhost:3000/"
    @iframeURL = "http://image.baidu.com/i?ie=utf-8&word=#{word}"
    puts "@iframeURL : #{@iframeURL}"
  end
end
