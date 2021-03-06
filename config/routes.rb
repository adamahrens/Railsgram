# == Route Map
#
#                          Prefix Verb     URI Pattern                                                                              Controller#Action
#                  comments_index GET      /comments/index(.:format)                                                                comments#index
#                 comments_create GET      /comments/create(.:format)                                                               comments#create
#                comments_destroy GET      /comments/destroy(.:format)                                                              comments#destroy
#                new_user_session GET      /users/login(.:format)                                                                   devise/sessions#new
#                    user_session POST     /users/login(.:format)                                                                   devise/sessions#create
#            destroy_user_session DELETE   /users/logout(.:format)                                                                  devise/sessions#destroy
# user_twitter_omniauth_authorize GET|POST /users/auth/twitter(.:format)                                                            users/omniauth_callbacks#passthru
#  user_twitter_omniauth_callback GET|POST /users/auth/twitter/callback(.:format)                                                   users/omniauth_callbacks#twitter
#               new_user_password GET      /users/password/new(.:format)                                                            devise/passwords#new
#              edit_user_password GET      /users/password/edit(.:format)                                                           devise/passwords#edit
#                   user_password PATCH    /users/password(.:format)                                                                devise/passwords#update
#                                 PUT      /users/password(.:format)                                                                devise/passwords#update
#                                 POST     /users/password(.:format)                                                                devise/passwords#create
#        cancel_user_registration GET      /users/cancel(.:format)                                                                  registrations#cancel
#           new_user_registration GET      /users/registration(.:format)                                                            registrations#new
#          edit_user_registration GET      /users/profile(.:format)                                                                 registrations#edit
#               user_registration PATCH    /users(.:format)                                                                         registrations#update
#                                 PUT      /users(.:format)                                                                         registrations#update
#                                 DELETE   /users(.:format)                                                                         registrations#destroy
#                                 POST     /users(.:format)                                                                         registrations#create
#                           users GET      /users(.:format)                                                                         users#index
#                            user GET      /users/:id(.:format)                                                                     users#show
#                      post_likes POST     /posts/:post_id/likes(.:format)                                                          likes#create
#                            like DELETE   /likes/:id(.:format)                                                                     likes#destroy
#                   post_comments GET      /posts/:post_id/comments(.:format)                                                       comments#index
#                                 POST     /posts/:post_id/comments(.:format)                                                       comments#create
#                         comment DELETE   /comments/:id(.:format)                                                                  comments#destroy
#                  post_bookmarks POST     /posts/:post_id/bookmarks(.:format)                                                      bookmarks#create
#                        bookmark DELETE   /bookmarks/:id(.:format)                                                                 bookmarks#destroy
#                           posts GET      /posts(.:format)                                                                         posts#index
#                                 POST     /posts(.:format)                                                                         posts#create
#                            post GET      /posts/:id(.:format)                                                                     posts#show
#                                 DELETE   /posts/:id(.:format)                                                                     posts#destroy
#                       home_home GET      /home/home(.:format)                                                                     home#home
#                            root GET      /                                                                                        posts#index
#              rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#       rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#              rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#       update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#            rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                            registrations: 'registrations' },
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           edit: 'profile',
                           sign_up: 'registration' }
  resources :users, only: %i[index show]
  resources :posts, only: %i[index show create destroy] do
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, only: %i[index create destroy], shallow: true
    resources :bookmarks, only: %i[create destroy], shallow: true
  end

  get 'home/home'
  root to: 'posts#index'
end
