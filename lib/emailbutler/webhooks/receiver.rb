# frozen_string_literal: true

require 'emailbutler/webhooks/mappers/sendgrid'

module Emailbutler
  module Webhooks
    class Receiver
      SENDGRID_USER_AGENT = 'SendGrid Event API'

      def self.call(args={})
        new.call(**args)
      end

      def call(user_agent:, payload:)
        select_mapper(user_agent)
          .call(payload: payload)
          .each { |event|
            message = Emailbutler.find_message_by(uuid: event.delete(:message_uuid))
            Emailbutler.create_message_event(message, event)
          }
      end

      private

      def select_mapper(user_agent)
        case user_agent
        when SENDGRID_USER_AGENT then Emailbutler::Webhooks::Mappers::Sendgrid
        end
      end
    end
  end
end
