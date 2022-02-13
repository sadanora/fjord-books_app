# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validates :avatar, content_type: { in: %w[image/jpg image/png image/gif] }

  # リサイズ済みのプロフィール画像を返す
  def display_avatar
    avatar.variant(resize_to_limit: [64, 64])
  end
end
