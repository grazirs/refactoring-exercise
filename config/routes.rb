Rails.application.routes.draw do
  post '/purchases', to: 'purchases#create'
end
