#coding: utf-8

class LoginController < ApplicationController

  def index
  end
  def auth
    user = User.authenticate(params[:email])
    if user then
      session[:user] = user.id
      redirect_to users_path
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザー名が間違っています。'
      render 'index'
    end
  end
end