FactoryGirl.define do
  factory :banner do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))
  end
end
