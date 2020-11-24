defmodule LiveViewUploadTestWeb.UploadComponent do
  use LiveViewUploadTestWeb, :live_component

  def render(assigns) do
    ~L"""
    <div>
    <%= for entry <- @uploads.avatar.entries do %>
    <%= entry.client_name %> - <%= entry.progress %>%
    <% end %>
    </div>

    <form phx-target="<%=@myself %>" phx-submit="save" phx-change="validate">
    <%= live_file_input @uploads.avatar %>
    <button type="submit">Upload</button>
    </form>
    """
  end

  def mount(socket) do
    {:ok,
     socket
     |> allow_upload(:avatar, accept: :any, max_entries: 2)}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", _params, socket) do
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join("priv/uploads", Path.basename(path))
      File.cp!(path, dest)
    end)

    {:noreply, socket}
  end
end
