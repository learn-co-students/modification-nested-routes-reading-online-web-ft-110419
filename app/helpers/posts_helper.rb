module PostsHelper
    def author_id_field(post)
        if post.author.nil?
            # Make sure there is no blank author 
          select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
        else
            # add this hidden_field below
          hidden_field_tag "post[author_id]", post.author_id
        end
      end
end
