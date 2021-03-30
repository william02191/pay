require "test_helper"

class Pay::Paddle::ErrorTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "gob@bluth.com", processor: :stripe)
  end

  test "re-raised paddle exceptions keep the same message" do

    exception = assert_raises {
      begin
        raise ::PaddlePay::ConnectionError, "The connection failed"
      rescue => e
        raise ::Pay::Paddle::Error
      end
    }

    assert_equal "The connection failed", exception.message
    assert_equal ::PaddlePay::ConnectionError, exception.cause.class
  end
end
