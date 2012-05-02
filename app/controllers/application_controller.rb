#coding: utf-8
class ApplicationController < ActionController::Base
  
  # ロケールの設定用フィルタ
  before_filter :detect_local
  # ログイン認証用のフィルタ
  before_filter :check_logined

  protect_from_forgery

  private
  def detect_local
  	I18n.locale = request.headers["Accept-Language"].scan(/^[a-z]{2}/).first
  end

  def check_logined
  	if session[:email]
  		begin
  			@user = UserInfo.find_all_by_user_id(session[:email])
  		rescue ActiveRecord::RecordNotFound
  			logger.error "セッションの情報(" + session[:email] +")は存在しません"
   			reset_session
  		end
	end

  	unless @user
  		flash[:referer] = request.fullpath
  		redirect_to :controller => 'login', :action => 'index'
  	end
  end
end

