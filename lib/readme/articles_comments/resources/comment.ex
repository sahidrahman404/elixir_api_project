defmodule Readme.ArticlesComments.Comment do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    integer_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute :content, :string do
      allow_nil?(false)
    end

    attribute :path, :string do
      allow_nil?(false)
      generated?(true)
    end

    attribute(:parent_path, :string)
  end

  postgres do
    table "articles_comments"
    repo Readme.Repo

    migration_ignore_attributes [
      :id,
      :created_at,
      :updated_at,
      :content,
      :path,
      :parent_path
    ]

    custom_statements do
      statement :articles_comments_table do
        up """
        create table articles_comments (
        -- primary key
        id bigserial primary key,

        -- surrogate key
        path ltree generated always as (coalesce(parent_path::text,'')::ltree || id::text::ltree) stored unique,

        -- foreign key
        parent_path ltree, 
        constraint fk_parent
        foreign key(parent_path) 
        references articles_comments(path)
        on delete cascade
        on update cascade,

        -- content
        content text,

        created_at timestamptz default current_timestamp,
        updated_at timestamptz default current_timestamp,

        accounts_id bigint references accounts(id) on delete cascade
        );
        """

        down """
          drop table articles_comments;
        """
      end
    end
  end
end
