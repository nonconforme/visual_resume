VisualResume::Application.routes.draw do
  post 'contact', :to => 'pages#contact'
  match '/:page', :to => 'pages#home', :as => :page
  root :to => "pages#home"
end
