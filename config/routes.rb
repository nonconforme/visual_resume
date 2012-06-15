VisualResume::Application.routes.draw do
  post 'contact', :to => 'pages#contact'
  match '/:page', :to => 'pages#home', :as => :page
  root :to => proc {|env| [200, {}, ["I'm alive"]] }, :constraints => { :user_agent => /NewRelicPinger/ }
  root :to => "pages#home"
end
