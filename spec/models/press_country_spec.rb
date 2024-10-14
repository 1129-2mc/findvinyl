require 'rails_helper'

RSpec.describe PressCountry, type: :model do

    context 'プレス国が255文字以内の場合' do
    it '有効であること' do
      press_country = build(:press_country, name: 'a' * 255)
      expect(press_country).to be_valid
    end
  end

  context 'プレス国が256文字以上の場合' do
    it '無効であること' do
      press_country = build(:press_country, name: 'a' * 256)
      expect(press_country).to be_invalid
      expect(press_country.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
