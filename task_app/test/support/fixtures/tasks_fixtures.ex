defmodule TaskApp.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskApp.Tasks` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        completed: true,
        title: "some title"
      })
      |> TaskApp.Tasks.create_todo()

    todo
  end
end
