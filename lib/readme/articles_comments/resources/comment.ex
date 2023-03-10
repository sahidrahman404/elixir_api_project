defmodule Readme.ArticlesComments.Comment do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type(:article_comment)

    queries do
      list(:list_comment, :read)
    end

    mutations do
      create :create_comment, :create_comment
      destroy(:delete_comment, :destroy)
    end
  end

  actions do
    defaults([:create, :read, :update, :destroy])

    create :create_comment do
      accept([:content, :parent_path])

      argument(:accounts_id, :integer)

      change(
        manage_relationship(:accounts_id, :accounts, type: :append_and_remove)
      )
    end
  end

  attributes do
    integer_primary_key(:id)

    create_timestamp :created_at do
       private? false
    end

    update_timestamp(:updated_at)

    attribute :content, :string do
      allow_nil?(false)
    end

    attribute :path, :string do
      allow_nil?(false)
      generated?(true)
    end

    attribute(:parent_path, :string, allow_nil?: true)
  end

  postgres do
    table "articles_comments"
    repo Readme.Repo

    migration_ignore_attributes [:path, :parent_path]

    custom_statements do
      statement :add_path_and_parent_path_column do
        up """
          alter table articles_comments
          add column parent_path ltree, 
          add column path ltree generated always as (coalesce(parent_path::text,'')::ltree || id::text::ltree) stored unique;
        """

        down """
          alter table articles_comments
          drop column path, 
          drop column parent_path;
        """
      end

      statement :add_constraint_parent_path do
        up """
        alter table articles_comments
        add constraint fk_parent
        foreign key(parent_path)
        references articles_comments(path)
        on delete cascade
        on update cascade;
        """

        down """
        alter table articles_comments
        drop constraint fk_parent;
        """
      end

      statement :add_index_accounts_id do
        up """
        create index articles_comments_account_id_idx on articles_comments(accounts_id);
        """

        down """
        drop index articles_comments_account_id_idx;
        """
      end

      statement :add_index_parent_path do
        up """
        create index articles_comments_parent_path_idx on articles_comments(parent_path asc nulls first);
        """

        down """
        drop index articles_comments_parent_path_idx;
        """
      end

      statement :add_index_path do
        up """
        create index articles_comments_path_idx on articles_comments using gist (path);;
        """

        down """
        drop index articles_comments_path_idx;
        """
      end
    end
  end

  relationships do
    belongs_to :accounts, Readme.Accounts.Account do
      api Readme.Accounts
      attribute_type(:integer)
    end

    has_many :articles_comments_likes, Readme.ArticlesComments.CommentLike do
      destination_attribute(:articles_comments_id)
    end
  end
end
