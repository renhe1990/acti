Rails.application.routes.draw do
  get '/auth/wechat/callback', to: 'weixin/sessions#callback'
  get '/auth/failure', to: 'weixin/sessions#failure'
  get 'images/show'

  root 'welcome#index'

  post '/tinymce_assets' => 'tinymce_assets#create'

  resource :qrcode do
    member do
      get :download
    end
  end
  resources :users
  resources :sessions
  resource :wechat, only: [:show, :create]
  resources :courses do
    resources :attachments
    member do
      get :new_step1
      get :new_step2
      get :new_step3
      get :new_step4
      patch :save_wizard
      get :preview
    end
  end
  resources :questions do
    resources :answers
  end
  resources :questionnaires do
    resources :attempts, only: [:index]
    member do
      get :qr_code
      get :copy
    end
  end
  resources :polls do
    resources :attempts, only: [:index]
    member do
      get :qr_code
      get :copy
    end
  end
  resources :courses do
    resources :questionnaires
    resources :polls
  end

  resources :public_courses do
    resources :questionnaires
    resources :polls
    member do
      post :copy
    end
  end

  resources :searches

  namespace :weixin do
    root 'welcome#index'

    resources :home
    resources :statics

    resources :sessions, only: [:new, :create]
    resources :bindings, only: [:new, :create, :show]
    resources :questionnaires do
      resources :attempts, only: [:index, :new, :create, :show]
    end
    resources :polls do
      resources :attempts, only: [:index, :new, :create, :show]
    end
    resources :opinionnaires do
      resources :reviews
      resources :attempts, only: [:create, :show]
    end
    resources :text_articles
    resources :video_articles
    resources :features
    resources :pages
    resources :cells
    resources :projects do
      resources :campaigns
      resources :features
    end
    resources :questions do
      resources :answers
    end
    resources :lucky_draws do
      resources :lucky_draw_results
    end
    resources :speech_draws do
      resources :speech_draw_results
    end
    resources :debate_draws do
      resources :debate_draw_results
    end
    resources :votes do
      resources :vote_results
    end
    resources :events
  end

  concern :sortable do
    collection do
      post :sort
    end
  end

  namespace :admin do
    # root 'welcome#index'
    root 'projects#index'

    resources :users do
      member do
        put :restore
        delete :delete
      end
      collection do
        post :import
      end
    end

    resources :features, concerns: [:sortable]
    resources :banners, concerns: [:sortable]
    resources :courses

    resources :menus, concerns: [:sortable] do
      collection do
        post :publish
      end
    end

    resources :projects, concerns: [:sortable] do
      member do
        post :copy
      end
      resources :campaigns, concerns: [:sortable]
      resources :cells, concerns: [:sortable]
      resources :banners, concerns: [:sortable]
      resources :features, concerns: [:sortable] do
        resource :photos
      end
    end

    resources :campaigns do
      resources :courses, concerns: [:sortable]
      resources :schedules, concerns: [:sortable]
    end

    resources :schedules do
      resources :activities, concerns: [:sortable]
      resources :lessons, concerns: [:sortable]
    end

    resources :courses do
      member do
        get :draw_results
      end
      resources :questionnaires, concerns: [:sortable]
      resources :polls, concerns: [:sortable]
      resources :opinionnaires, concerns: [:sortable]
      resources :lucky_draws, concerns: [:sortable]
      resources :speech_draws, concerns: [:sortable]
      resources :debate_draws, concerns: [:sortable]
      resources :votes, concerns: [:sortable]
    end

    resources :pages
    resources :searches
    resources :public_courses do
      resources :polls, concerns: [:sortable]
      resources :questionnaires, concerns: [:sortable]
    end
  end

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'

  get 'sign_up', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
end
