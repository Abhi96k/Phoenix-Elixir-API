defmodule Forum.PostFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forum.Post` context.
  """

  @doc """
  Generate a posts.
  """
  def posts_fixture(attrs \\ %{}) do
    {:ok, posts} =
      attrs
      |> Enum.into(%{
        body: "some body",
        posts: "some posts",
        title: "some title"
      })
      |> Forum.Post.create_posts()

    posts
  end
end
