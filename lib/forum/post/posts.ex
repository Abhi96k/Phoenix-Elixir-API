defmodule Forum.Post.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :posts, :string
    field :body, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(posts, attrs) do
    posts
    |> cast(attrs, [:posts, :body, :title])
    |> validate_required([:posts, :body, :title])
  end
end
