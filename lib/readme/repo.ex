defmodule Readme.Repo do
  use AshPostgres.Repo, otp_app: :readme

  def installed_extensions do
    ["uuid-ossp", "citext", "ltree"]
  end
end

