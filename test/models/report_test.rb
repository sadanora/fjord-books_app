# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @report = reports(:report_of_alice)
  end

  test '#editable?' do
    assert @report.editable?(@alice)
    assert_not @report.editable?(@bob)
  end

  test '#created_on' do
    @report.created_at = '2022-04-25 10:00:00.000000'
    assert_equal Date.new(2022, 4, 25), @report.created_on
  end
end
