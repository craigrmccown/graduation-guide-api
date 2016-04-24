Rails.application.routes.draw do
  post 'auth/login' => 'auth#login'
  post 'auth/logout' => 'auth#logout'
  post 'auth/register' => 'user#new'
  get 'auth/whoami' => 'user#show'

  get 'majors' => 'major#show'
  put 'majors' => 'major#update'

  get 'majors/:id/tracks' => 'track#show'
  put 'tracks' => 'track#update'

  get 'minors' => 'minor#show'
  put 'minors' => 'minor#update'

  get 'courses' => 'course#show'
  get 'courses/completed' => 'course#show_completed'
  put 'courses/completed' => 'course#update_completed'

  get 'prereqs' => 'prereq#show'
  get 'course-groups' => 'course_group#show'
  get 'requirements' => 'requirement#show'

  match '*path', to: 'application#missing_endpoint', via: :all
end
