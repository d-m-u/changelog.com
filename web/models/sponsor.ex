defmodule Changelog.Sponsor do
  use Changelog.Web, :model
  use Arc.Ecto.Schema

  alias Changelog.Regexp

  schema "sponsors" do
    field :name, :string
    field :description, :string
    field :website, :string
    field :github_handle, :string
    field :twitter_handle, :string
    field :logo_image, Changelog.LogoImage.Type

    has_many :episode_sponsors, Changelog.EpisodeSponsor, on_delete: :delete_all

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(description website github_handle twitter_handle)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, ~w(logo_image))
    |> validate_format(:website, Regexp.http, message: Regexp.http_message)
    |> unique_constraint(:name)
  end
end
