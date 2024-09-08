require "test_helper"

class MeasurementUnitTest < ActiveSupport::TestCase

  fixtures :measurement_units
  test "name and symbol should be present to create new unit" do
    measurement_unit = MeasurementUnit.new(name: "Uniquename", symbol: "Symbolunique")
    assert measurement_unit.save, "Failed to save valid measurement unit: #{measurement_unit.errors.full_messages.join(", ")}"
  end

  test "name shouldn't be duplicate" do
    measurement_unit = MeasurementUnit.new(name: measurement_units(:one).name, symbol: "Symbolunique")
    assert_not measurement_unit.save, "Saved unvalid measurement unit"
  end

  test "symbol shouldn't be duplicate" do
    measurement_unit = MeasurementUnit.new(name: "UniqueName", symbol: measurement_units(:one).symbol)
    assert_not measurement_unit.save, "Saved unvalid measurement unit"
  end

  test "should save just if name and symbol are filled" do
    measurement_unit = MeasurementUnit.new(name: "", symbol: "")
    assert_not measurement_unit.save, "Saved unvalid measurement unit"
  end

  test "should have Relation has many with ingredients" do
    measurement_unit = MeasurementUnit.reflect_on_association(:ingredients)
    assert_equal(measurement_unit.macro, :has_many)
  end

end
