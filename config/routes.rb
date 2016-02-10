Rails.application.routes.draw do
  post 'auth/login' => 'auth#login'
  post 'auth/logout' => 'auth#logout'
  post 'users' => 'user#register_student'
  get 'users/me' => 'user#whoami'
  post 'users/me/majors' => 'user#add_majors'
  post 'users/me/tracks' => 'user#add_tracks'
  post 'users/me/minors' => 'user#add_minors'
  get 'majors' => 'major#get_all'
  get 'majors/:id/tracks' => 'track#get_by_major'
  get 'minors' => 'minor#get_all'
  get 'courses' => 'course#get_all_for_user'
  match '*path', to: 'application#missing_endpoint', via: :all
end
