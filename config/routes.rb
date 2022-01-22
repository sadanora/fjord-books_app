Rails.application.routes.draw do
  root 'books#index'
  resources :books
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, :only => [:index, :show]
  get '/mypage', to: 'mypage#show'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
