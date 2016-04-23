Rails.application.routes.draw do
  namespace :auth do
    post 'login' => 'auth#login'
    post 'logout' => 'auth#logout'
    post 'register' => 'user#new'
    get 'whoami' => 'user#show'
  end

  get 'majors' => 'major#show'
  put 'majors' => 'major#update'

  get 'majors/:id/tracks' => 'track#show'
  put 'tracks' => 'track#update'

  get 'minors' => 'minor#show'
  put 'minors' => 'minor#update'

  get 'courses' => 'course#show'
  get 'courses/completed' => 'course#show_completed'
  put 'courses/completed' => 'course#update_completed'

  match '*path', to: 'application#missing_endpoint', via: :all
end
