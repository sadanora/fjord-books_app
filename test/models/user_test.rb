# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test "#follow" do
    assert_not @alice.following?(@bob)
    @alice.follow(@bob)
  end

  test "#following" do
    assert_not @alice.following?(@bob)
    @alice.follow(@bob)
    assert @alice.following?(@bob)
    assert @bob.followed_by?(@alice)
  end

  test "#unfollow" do
    assert_not @alice.following?(@bob)
    @alice.follow(@bob)
    assert @alice.following?(@bob)
    assert @bob.followed_by?(@alice)
    @alice.unfollow(@bob)
    assert_not @alice.following?(@bob)
  end

  test "#followed_by?" do
    @alice.follow(@bob)
    assert @alice.following?(@bob)
    assert @bob.followed_by?(@alice)
    @alice.unfollow(@bob)
    assert_not @alice.following?(@bob)
  end

  test "#name_or_email" do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email
    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end
end
