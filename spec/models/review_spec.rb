describe Review, type: :model do
  it { is_expected.to  belong_to :restaurant }

  let!(:abokado) {Restaurant.create(name: 'Abokado')}

  it 'should remove the review wheen the restaurant is deleted' do
    r = Review.new(thoughts: "meh meh")
    r.save!
    abokado.reviews << r
    expect{abokado.destroy}.to change {Review.count}.by(-1)
  end
end
