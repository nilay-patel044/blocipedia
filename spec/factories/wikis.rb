FactoryGirl.define do
  factory :wiki do
    title "New Wiki Title"
    body "New Wiki Body Goes Here"
    private false
    user nil
  end
end
