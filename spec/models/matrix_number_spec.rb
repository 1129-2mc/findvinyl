require 'rails_helper'

RSpec.describe MatrixNumber, type: :model do

  context 'マトリクスナンバーが255文字以内の場合' do
    it '有効であること' do
      matrix_number = build(:matrix_number, number: 'a' * 255)
      expect(matrix_number).to be_valid
    end
  end

  context 'マトリクスナンバーが256文字以上の場合' do
    it '無効であること' do
      matrix_number = build(:matrix_number, number: 'a' * 256)
      expect(matrix_number).to be_invalid
      expect(matrix_number.errors[:number]).to include('は255文字以内で入力してください')
    end
  end
end
