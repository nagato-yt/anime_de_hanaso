class Public::HomesController < ApplicationController
  def top
    @posts = Post.all
    @groups = Group.all
  end
  
  
end
