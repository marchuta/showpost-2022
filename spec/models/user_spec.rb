require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '必要な事項を全て記入していれば新規登録できる。' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ニックネームがなければ、新規登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'emailアドレスがなければ、新規登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it '重複したemailが存在する場合、新規登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailアドレスに@が含まれていなければ、新規登録できないこと' do
        @user.email = 'aaaaaa.com'

        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordがなければ、新規登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが５文字以下であれば、新規登録できないこと' do
        @user.password = 'aaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが半角英数字の混合でなければ、新規登録できないこと(ひらがなを入れると登録できない)' do
        @user.password = 'あ11aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end

      it 'passwordが半角英数字の混合でなければ、新規登録できないこと(数字だけでは登録できない)' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end

      it 'passwordが半角英数字の混合でなければ、新規登録できないこと(英字だけでは登録できない)' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end

      it 'passwordとpassword_conformationが一致していなければ、新規登録できないこと' do
        @user.password = '111aaa'
        @user.password_confirmation = '111aab'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'お名前(全角)の名字名前がそれぞれなければ、新規登録できないこと' do
        @user.last_name_kanji = ''
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください', '名前を入力してください')
      end

      it 'お名前(全角)が全角(漢字、カタカナ、ひらがな)でなければ、新規登録できないこと' do
        @user.last_name_kanji = '111aaa'
        @user.first_name_kanji = '111aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字全角文字を使用してください', '名前全角文字を使用してください')
      end

      it 'お名前カナ(全角)の名字名前がなければ、新規登録できないこと' do
        @user.last_name_katakana = ''
        @user.first_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字(カタカナ)を入力してください', '名前(カタカナ)を入力してください')
      end

      it 'お名前カナ(全角)が全角(カタカナ)でなければ、新規登録できないこと' do
        @user.last_name_katakana = '嗚呼aaa'
        @user.first_name_katakana = '嗚呼aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字(カタカナ)全角文字を使用してください', '名前(カタカナ)全角文字を使用してください')
      end

      it 'birthdayが入力されていなければ、新規登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('誕生日を入力してください')
      end
    end
  end
end
