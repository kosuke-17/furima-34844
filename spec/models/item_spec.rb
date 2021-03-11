require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'name,price,image,description,category_id,status_id,cost_id,prefecture_id,delivery_idが存在していれば登録できること' do
      expect(@item).to be_valid
    end

    it 'imageが空では保存できないこと' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'nameが空では保存できないこと' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it 'descriptionが空では保存できないこと' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'category_idが空では保存できないこと' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category is not a number")
    end
    it 'status_idが空では保存できないこと' do
      @item.status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Status is not a number")
    end
    it 'cost_idが空では保存できないこと' do
      @item.cost_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Cost is not a number")
    end
    it 'prefecture_idが空では保存できないこと' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture is not a number")
    end
    it 'delivery_idが空では保存できないこと' do
      @item.delivery_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery is not a number")
    end
    it 'priceが空では保存できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'userが紐付いていないと保存できないこと' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
    it 'priceは半角数字でなければ保存できない' do
      @item.price = "１２３４５"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price 半角数字で入力してください")
    end
    it 'priceは、¥300~¥9,999,999の間でなければ保存できないこと' do
      @item.price = "100"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price ¥300~¥9,999,999の間で金額入力してください")
    end
  end
end
