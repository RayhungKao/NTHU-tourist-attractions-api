# frozen_string_literal: true

require 'json'
require 'sequel'

module NTHUtouristAttractions
  class Geoinfo < Sequel::Model
    plugin :timestamps, update_on_create: true
    plugin :whitelist_security
    set_allowed_columns :uuid, :latitude, :longitude, :targetID, :entryOrExit

    # Secure getters and setters
    def latitude
      SecureDB.decrypt(latitude_secure)
    end

    def latitude=(plaintext)
      self.latitude_secure = SecureDB.encrypt(plaintext)
    end

    def longitude
        SecureDB.decrypt(longitude_secure)
      end
  
      def longitude=(plaintext)
        self.longitude_secure = SecureDB.encrypt(plaintext)
      end

    # rubocop:disable Metrics/MethodLength
    def to_json(options = {})
      JSON(
        {
          type: 'geoInfo',
          attributes: {
            uuid:,
            latitude:,
            longitude:,
            targetID:,
            entryOrExit:
          },
        }, options
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
