defmodule ForumWeb.PostsControllerTest do
  use ForumWeb.ConnCase

  import Forum.PostFixtures
  alias Forum.Post.Posts

  @create_attrs %{
    title: "some title",
    body: "some body",
    posts: "some posts"
  }
  @update_attrs %{
    title: "some updated title",
    body: "some updated body",
    posts: "some updated posts"
  }
  @invalid_attrs %{title: nil, body: nil, posts: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all post", %{conn: conn} do
      conn = get(conn, ~p"/api/post")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create posts" do
    test "renders posts when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/post", posts: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/post/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some body",
               "posts" => "some posts",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/post", posts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update posts" do
    setup [:create_posts]

    test "renders posts when data is valid", %{conn: conn, posts: %Posts{id: id} = posts} do
      conn = put(conn, ~p"/api/post/#{posts}", posts: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/post/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some updated body",
               "posts" => "some updated posts",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, posts: posts} do
      conn = put(conn, ~p"/api/post/#{posts}", posts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete posts" do
    setup [:create_posts]

    test "deletes chosen posts", %{conn: conn, posts: posts} do
      conn = delete(conn, ~p"/api/post/#{posts}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/post/#{posts}")
      end
    end
  end

  defp create_posts(_) do
    posts = posts_fixture()

    %{posts: posts}
  end
end
