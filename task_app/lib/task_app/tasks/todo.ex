defmodule TaskApp.Tasks.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :completed, :boolean, default: false
    field :title, :string
    field :notified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed])
    # |> validate_required([:title, :completed])
    |> validate_required([:title])
  end

  # Add_ons in todo.ex
  def toggle_completed(id) do
    todo = Repo.get!(Todo, id)

    todo
    |> Ecto.Changeset.change(%{completed: !todo.completed})
    |> Repo.update()
  end

  def get_todo!(id) do
    Repo.get!(Todo, id)
  end

  def update_notified(id, notified) do
    todo = get_todo!(id)

    todo
    |> Ecto.Changeset.change(%{notified: notified})
    |> Repo.update()
  end
end
