# frozen_string_literal: true

FactoryBot.define do
  factory :emailbutler_event, class: Emailbutler.adapter.event_class do
    status { 'processed' }
    association :emailbutler_message
  end
end
