defmodule TaskApp.TasksTest do
  use TaskApp.DataCase

  alias TaskApp.Tasks

  describe "todos" do
    alias TaskApp.Tasks.Todo

    import TaskApp.TasksFixtures

    @invalid_attrs %{completed: nil, title: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Tasks.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Tasks.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{completed: true, title: "some title"}

      assert {:ok, %Todo{} = todo} = Tasks.create_todo(valid_attrs)
      assert todo.completed == true
      assert todo.title == "some title"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{completed: false, title: "some updated title"}

      assert {:ok, %Todo{} = todo} = Tasks.update_todo(todo, update_attrs)
      assert todo.completed == false
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_todo(todo, @invalid_attrs)
      assert todo == Tasks.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Tasks.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Tasks.change_todo(todo)
    end
  end
end
