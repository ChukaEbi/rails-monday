describe Review, type: :model do
  it { is_expected.to  belong_to :restaurant }

  it { is_expected.to belong_to :user }
  let!(:abokado) {Restaurant.create(name: 'Abokado')}


  it 'should remove the review wheen the restaurant is deleted' do
    r = Review.new(thoughts: "meh meh", rating: 3)
    r.save!
    abokado.reviews << r
    expect{abokado.destroy}.to change {Review.count}.by(-1)
  end

  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
