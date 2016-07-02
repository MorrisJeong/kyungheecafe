
require 'mailgun'
class HomeController < ApplicationController

  
  def index
    @posts = Post.all.reverse
  end

  def write
    #post = Post.new
    #post.title = params[:title]
    #post.content = params[:content]
    #post.save
    
    post = Post.new(title: params[:title], content: params[:content])
    
    if post.save
      redirect_to "/home/index"
    else
      render :text => post.errors.messages[:title].first
    end  
    
  end

  def comment_write
     comment = Comment.new
     comment.content = params[:content]
     comment.post_id = params[:id_of_post]
     comment.save
     
     redirect_to "/home/index"
  end
  def emailwrite
    @title = params[:title]
    @receiver = params[:email]
    @content = params[:content]
    
    mg_client = Mailgun::Client.new("key-22f2f3ea49ed1a5000b1585fef994a49")

    message_params =  {
                       from: 'seoyj21@naver.com',
                       to:  @receiver ,
                       subject: @title,
                       text: @content
                      }
    
    result = mg_client.send_message('sandboxfbb9a6971e6f4bf6aad62c9206aceed7.mailgun.org', message_params).to_h!
    
    message_id = result['id']
    message = result['message']
    redirect_to "/"
    
  end
  def manage
    
  
  end
end
