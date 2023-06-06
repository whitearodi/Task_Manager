defmodule TaskAppWeb.TodoLiveTest do
  use TaskAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import TaskApp.TasksFixtures

  @create_attrs %{completed: true, title: "some title"}
  @update_attrs %{completed: false, title: "some updated title"}
  @invalid_attrs %{completed: false, title: nil}

  defp create_todo(_) do
    todo = todo_fixture()
    %{todo: todo}
  end

  describe "Index" do
    setup [:create_todo]

    test "lists all todos", %{conn: conn, todo: todo} do
      {:ok, _live, html} = live(conn, ~p(/todos))

      assert html =~ "Listing Todos"
      assert html =~ todo.title
    end

    test "saves new todo", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p(/todos))

      assert live |> element("a", "New Todo") |> render_click() =~
               "New Todo"

      assert_patch(live, ~p(/todos/new))

      assert live
             |> form("#todo-form", todo: @invalid_attrs)
             |> render_change()

      assert live
             |> form("#todo-form", todo: @create_attrs)
             |> render_submit()

      assert_patch(live, ~p(/todos))

      html = render(live)
      assert html =~ "Todo created successfully"
      assert html =~ "some title"
    end

    test "updates todo in listing", %{conn: conn, todo: todo} do
      {:ok, live, _html} = live(conn, ~p(/todos))

      assert live |> element("#todos-#{todo.id} a", "Edit") |> render_click() =~
               "Edit Todo"

      assert_patch(live, ~p"/todos/#{todo}/edit")

      assert live
             |> form("#todo-form", todo: @invalid_attrs)
             |> render_change()

      assert live
             |> form("#todo-form", todo: @update_attrs)
             |> render_submit()

      assert_patch(live, ~p(/todos))

      html = render(live)
      assert html =~ "Todo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes todo in listing", %{conn: conn, todo: todo} do
      {:ok, live, _html} = live(conn, ~p(/todos))

      assert live |> element("#todos-#{todo.id} a", "Delete") |> render_click()
      refute has_element?(live, "#todos-#{todo.id}")
    end
  end

  describe "Show" do
    setup [:create_todo]

    test "displays todo", %{conn: conn, todo: todo} do
      {:ok, _live, html} = live(conn, ~p(/todos/#{todo}))

      assert html =~ "Show Todo"
      assert html =~ todo.title
    end

    test "updates todo within modal", %{conn: conn, todo: todo} do
      {:ok, live, _html} = live(conn, ~p(/todos/#{todo}))

      assert live |> element("a", "Edit") |> render_click() =~
               "Edit Todo"

      assert_patch(live, ~p(/todos/#{todo}/show/edit))

      assert live
             |> form("#todo-form", todo: @invalid_attrs)
             |> render_change()

      assert live
             |> form("#todo-form", todo: @update_attrs)
             |> render_submit()

      assert_patch(live, ~p(/todos/#{todo}))

      html = render(live)
      assert html =~ "Todo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
