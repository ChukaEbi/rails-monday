describe Review, type: :model do
  it { is_expected.to  belong_to :restaurant }

  let!(:abokado) {Restaurant.create(name: 'Abokado')
  it 'should remove the review wheen the restaurant is deleted' do
  end
end
