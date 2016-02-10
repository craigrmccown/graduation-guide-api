Rails.application.routes.draw do
  post 'auth/login' => 'auth#login'
  post 'auth/logout' => 'auth#logout'
  post 'users' => 'user#register_student'
end
