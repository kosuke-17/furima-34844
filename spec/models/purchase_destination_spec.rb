require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  describe '購入履歴の保存' do
      before do
      user_id = 1
      item_id = 2
        @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user_id, item_id: item_id)
      end
    context '購入履歴を保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_destination).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_destination.building_name = ''
      expect(@purchase_destination).to be_valid
      end
    end
    context '購入履歴を保存できない場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it 'prefecture_idが空では保存できないこと' do
        @purchase_destination.prefecture_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1では保存できないこと' do
        @purchase_destination.prefecture_id = 1
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityは空では保存できないこと' do
        @purchase_destination.city = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("City can't be blank")
      end
      it 'addressは空では保存できないこと' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberは空では保存できないこと' do
        @purchase_destination.phone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Item can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_destination.post_code = 1234567
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "tokenが空では登録できないこと" do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Token can't be blank")
      end
      it 'phone_numberは数字でないと登録できない' do
        @purchase_destination.phone_number = '0000000000a'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Phone number Input only number")
      end
    end
  end
end
