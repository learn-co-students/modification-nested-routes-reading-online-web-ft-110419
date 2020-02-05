Rails.application.routes.draw do
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end
  resources :posts
end
#This gives us access to /authors/:author_id/posts/new, and a new_author_post_path helper.
