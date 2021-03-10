require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nameとemail、password、password_confirmation、family_name、first_name、family_name_kana、first_name_kana、birtth_dayが存在すれば登録できる' do
        expect(@user).to be_valid 
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'family_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.family_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end
      it 'family_name_kanaは全角（カタカナ）でなければ登録できない' do
        @user.family_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角文字を使用してください")
      end
      it 'first_name_kanaは全角（カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください")
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        expect(@user.errors.full_messages).to include("Password 半角英数字混在で入力してください")
      end
      it 'passwordが半角英字のみの場合は登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        binding.pry
        expect(@user.errors.full_messages).to include("Password 半角英数字混在で入力してください")
      end
      it 'passwordが全角の場合は登録できない' do
        @user.password = 'てすとてすと'
        @user.password_confirmation = 'てすとてすと'
        expect(@user.errors.full_messages).to include("Password 半角英数字混在で入力してください")
      end
      it 'emailは@が含まれていないと登録ができない' do
        @user.email = 'samplesample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
    end
  end
end
