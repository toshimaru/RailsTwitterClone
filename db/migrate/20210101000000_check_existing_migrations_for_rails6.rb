# frozen_string_literal: true

# Database schema has been newly created in Rails 6.
#
# This migration file checks there's an old migration invoked in the past and
# if any, raise an error to enforce `db:reset`.
#
# CAUTION: ALL DATA WILL BE CLEARED IF YOU RESET DATABASE.
class CheckExistingMigrationsForRails6 < ActiveRecord::Migration[6.0]
  OLD_MIGRATION_VERSIONS = [20140307124026, 20140315090930, 20140315103002, 20140317214823, 20140319034048,
                            20140323031217, 20140326232214, 20140725142845, 20201231000000]

  def change
    if migration_from_rails5?
      raise StandardError, <<~MIGRATION_MSG
        Plese run `bin/rails db:reset`.

        CAUTION:
        All data will be cleared if you reset database and new tables will be
        created in the next migrations.
      MIGRATION_MSG
    end
  end

  private
    def migration_from_rails5?
      migration_context.get_all_versions.any? { |version| version.in?(OLD_MIGRATION_VERSIONS) }
    end
end
