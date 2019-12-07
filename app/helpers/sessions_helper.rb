module SessionsHelper

	#渡されたユーザーでログインする
	def log_in(user)
		session[:user_id] = user.id
	end

	# #現在ログイン中のユーザーを返す（いる場合）8章
	# def current_user
	# 	if session[:user_id]
	# 		 @current_user ||= User.find_by(id: session[:user_id])
	# 	end
	# end

# 記憶トークンcookieに対応するユーザーを返す（9章で更新された）
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:rememmber, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	# ユーザーがログインしていればtrue、その他ならfalseを返す
	def logged_in?
		!current_user.nil?
	end

	# 現在のユーザーをログアウトする
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	#渡されたユーザーがログイン済であれば（１０章リスト10.27)
	def current_user?(user)
		user == current_user
	end

	#記憶したURL（もしくはデフォルト値）にリダイレクト
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	#アクセスしようとしたURLを覚えておく
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end


