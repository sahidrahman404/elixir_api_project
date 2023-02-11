defmodule Readme.Repo do
  use AshPostgres.Repo, otp_app: :readme

  def installed_extensions do
    ["citext", "ltree"]
  end
end

