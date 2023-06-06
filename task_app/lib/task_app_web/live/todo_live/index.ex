defmodule TaskAppWeb.TodoLive.Index do
  use TaskAppWeb, :live_view
  use Phoenix.HTML
  alias TaskApp.Tasks
  alias TaskApp.Tasks.Todo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :todos, Tasks.list_todos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, Tasks.get_todo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, %Todo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:todo, nil)
  end

  @impl true
  def handle_info({TaskAppWeb.TodoLive.FormComponent, {:saved, todo}}, socket) do
    {:noreply, stream_insert(socket, :todos, todo)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = Tasks.get_todo!(id)
    {:ok, _} = Tasks.delete_todo(todo)

    {:noreply, stream_delete(socket, :todos, todo)}
  end
end
