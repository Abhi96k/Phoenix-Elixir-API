defmodule ForumWeb.PageController do
  use ForumWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def users(conn, _params) do
    IO.puts("Users route hit")
    users=[
      %{id: 1, name: "Alice"},
      %{id: 2, name: "Bob"},
      %{id: 3, name: "Charlie"}
    ]
    render(conn, :users, users: users)
  end
end
