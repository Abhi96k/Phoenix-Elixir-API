defmodule ForumWeb.PostsJSON do
  alias Forum.Post.Posts

  @doc """
  Renders a list of post.
  """
  def index(%{post: post}) do
    %{data: for(posts <- post, do: data(posts))}
  end

  @doc """
  Renders a single posts.
  """
  def show(%{posts: posts}) do
    %{data: data(posts)}
  end

  defp data(%Posts{} = posts) do
    %{
      id: posts.id,
      posts: posts.posts,
      body: posts.body,
      title: posts.title
    }
  end
end
