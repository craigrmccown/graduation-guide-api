Rails.application.routes.draw do
  post 'auth/login' => 'auth#login'
  post 'auth/logout' => 'auth#logout'
  post 'users' => 'user#register_student'
  get 'users/me' => 'user#whoami'
  post 'users/me/majors' => 'user#add_majors'
  post 'users/me/minors' => 'user#add_minors'
  get 'majors' => 'major#get_all'
  get 'minors' => 'minor#get_all'
  match '*path', to: 'application#missing_endpoint', via: :all
end
