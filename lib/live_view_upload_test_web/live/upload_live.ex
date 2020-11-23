defmodule LiveViewUploadTestWeb.UploadLive do
  use LiveViewUploadTestWeb, :live_view

  alias LiveViewUploadTestWeb.UploadComponent

  def render(assigns) do
    ~L"""
    <%= live_component(@socket, UploadComponent, id: UploadComponent) %>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
