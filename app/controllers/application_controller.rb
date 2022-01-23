# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action do
    I18n.locale = :ja
  end
end
