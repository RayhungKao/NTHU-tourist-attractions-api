# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:geoinfos) do
      primary_key :id

      String :uuid, null: false
      String :latitude_secure
      String :longitude_secure
      String :targetID
      Boolean :entryOrExit

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
