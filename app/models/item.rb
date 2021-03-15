class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :cost
  belongs_to :delivery
  belongs_to :prefecture
  belongs_to :status
  
  belongs_to :user
  has_one_attached :image
  has_one :purchase, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :image
    validates :description
    validates :price, numericality: { only_integer: true, message: '半角数字で入力してください' }
    validates :price, numericality: { greater_than: 299, less_than: 10000000, message: '¥300~¥9,999,999の間で金額入力してください'}
  end
    with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :cost_id
    validates :delivery_id
    validates :prefecture_id
    validates :status_id
  end
end
