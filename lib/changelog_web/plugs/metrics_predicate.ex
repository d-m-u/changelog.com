defmodule ChangelogWeb.Plugs.MetricsPredicate do
  @moduledoc """
  This Unplug predicate is used to authorize requests to the PromEx metrics
  """

  @behaviour Unplug.Predicate

  @impl true
  def call(conn, _) do
    conn
    |> Plug.Conn.get_req_header("authorization")
    |> case do
      ["Bearer " <> token] ->
        token == System.get_env("PROMETHEUS_AUTHORIZATION")

      _ ->
        false
    end
  end
end
