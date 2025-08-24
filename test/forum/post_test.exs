defmodule Forum.PostTest do
  use Forum.DataCase

  alias Forum.Post

  describe "post" do
    alias Forum.Post.Posts

    import Forum.PostFixtures

    @invalid_attrs %{title: nil, body: nil, posts: nil}

    test "list_post/0 returns all post" do
      posts = posts_fixture()
      assert Post.list_post() == [posts]
    end

    test "get_posts!/1 returns the posts with given id" do
      posts = posts_fixture()
      assert Post.get_posts!(posts.id) == posts
    end

    test "create_posts/1 with valid data creates a posts" do
      valid_attrs = %{title: "some title", body: "some body", posts: "some posts"}

      assert {:ok, %Posts{} = posts} = Post.create_posts(valid_attrs)
      assert posts.title == "some title"
      assert posts.body == "some body"
      assert posts.posts == "some posts"
    end

    test "create_posts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Post.create_posts(@invalid_attrs)
    end

    test "update_posts/2 with valid data updates the posts" do
      posts = posts_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body", posts: "some updated posts"}

      assert {:ok, %Posts{} = posts} = Post.update_posts(posts, update_attrs)
      assert posts.title == "some updated title"
      assert posts.body == "some updated body"
      assert posts.posts == "some updated posts"
    end

    test "update_posts/2 with invalid data returns error changeset" do
      posts = posts_fixture()
      assert {:error, %Ecto.Changeset{}} = Post.update_posts(posts, @invalid_attrs)
      assert posts == Post.get_posts!(posts.id)
    end

    test "delete_posts/1 deletes the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{}} = Post.delete_posts(posts)
      assert_raise Ecto.NoResultsError, fn -> Post.get_posts!(posts.id) end
    end

    test "change_posts/1 returns a posts changeset" do
      posts = posts_fixture()
      assert %Ecto.Changeset{} = Post.change_posts(posts)
    end
  end
end
