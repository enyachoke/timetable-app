TimetableApp::Application.routes.draw do
  devise_for :users

  namespace :workplace do
    resources :organizations, :except => [:index] do
      resources :lecturers, :except => [:show, :index] do
        post :import, :on => :collection
      end
      resources :memberships, :except => [:show, :index]

      resources :buildings, except: [:show, :index] do
        post :import, :on => :collection
        resources :classrooms, except: [:show, :index]
      end

      resources :timetables do
        resources :groups, except: [:index, :show]
        resources :lesson_times
        resources :weeks, except: [:index, :new, :edit] do
          resources :days, only: [] do
            resources :lessons, except: [:index, :show]
          end
        end
      end
    end

    root :to => 'workplace#index'
  end

  root :to => 'application#main_page'
end
