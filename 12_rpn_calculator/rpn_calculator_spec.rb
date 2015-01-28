# # Topics
# * arrays
# * arithmetic
# * strings
#
# # RPN Calculator
#
# "RPN" stands for "Reverse Polish Notation". (See [the wikipedia entry](http://en.wikipedia.org/wiki/Reverse_Polish_notation) for more information on this colorful term.) Briefly, in an RPN world, instead of using normal "infix" notation, e.g.
#
#     2 + 2
#
# you use "postfix" notation, e.g.
#
#     2 2 +
#
# While this may seem bizarre, there are some advantages to doing things this way. For one, you never need to use parentheses, since there is never any ambiguity as to what order to perform operations in. The rule is, you always go from the back, or the left side.
#
#     1 + 2 * 3 =>
#     (1 + 2) * 3 or
#     1 + (2 * 3)
#
#     1 2 + 3 * => (1 + 2) * 3
#     1 2 3 * + => 1 + (2 * 3)
#
# Another advantage is that you can represent any mathematical formula using a simple and elegant data structure, called a [stack](http://en.wikipedia.org/wiki/Stack_(data_structure)).
#
# # Hints
#
# Ruby doesn't have a built-in stack, but the standard Array has all the methods you need to emulate one (namely, `push` and `pop`, and optionally `size`).
#

# See
# * <http://en.wikipedia.org/wiki/Reverse_Polish_notation>
# * <http://www.calculator.org/rpn.aspx>
#
require "rpn_calculator"

describe RPNCalculator do

  attr_accessor :calculator

  before do
    @calculator = RPNCalculator.new
  end

  it "adds two integers" do
    calculator.push(2)
    calculator.push(3)
    calculator.plus
    calculator.value.should == 5
  end

  it "adds two floats" do
    calculator.push(2.4)
    calculator.push(3.6)
    calculator.plus
    calculator.value.round(1).should == 6.0
  end

  it "adds two rationals" do
    calculator.push(0.22E-4)
    calculator.push(1.33E-3)
    calculator.plus
    calculator.value.round(6).should == 1.352E-3
  end

  it "adds three integers" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.plus
    calculator.value.should == 7
    calculator.plus
    calculator.value.should == 9
  end

  it "adds three floats" do
    calculator.push(2.2)
    calculator.push(3.3)
    calculator.push(4.4)
    calculator.plus
    calculator.value.round(1).should == 7.7
    calculator.plus
    calculator.value.round(1).should == 9.9
  end

  it "adds three rationals" do
    calculator.push(0.22E-3)
    calculator.push(3.12E-4)
    calculator.push(4.56E-3)
    calculator.plus
    calculator.value.round(6).should == 4.872E-3
    calculator.plus
    calculator.value.round(6).should == 5.092E-3
  end

  it "subtracts the second number from the first number" do
    calculator.push(2)
    calculator.push(3)
    calculator.minus
    calculator.value.should == -1
  end

  it "adds and subtracts" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.minus
    calculator.value.should == -1
    calculator.plus
    calculator.value.should == 1
  end

  it "multiplies and divides" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.divide
    calculator.value.should == (3.0 / 4.0)
    calculator.times
    calculator.value.should == 2.0 * (3.0 / 4.0)
  end

  it "adds, subtracts, multiplies and divides floats" do
    calculator.push(2.5)
    calculator.push(3.7)
    calculator.push(1.8)
    calculator.push(2.6)
    calculator.push(3.2)
    calculator.plus
    calculator.value.round(1).should == 5.8
    calculator.minus
    calculator.value.round(1).should == -4.0
    calculator.times
    calculator.value.round(1).should == -14.8
    calculator.divide
    calculator.value.round(6).should == -0.168919
  end

  it "adds, subtracts, multiplies and divides rationals" do
    calculator.push(2.5E3)
    calculator.push(3.7E2)
    calculator.push(1.8E2)
    calculator.push(2.6E-4)
    calculator.push(3.2E-3)
    calculator.plus
    calculator.value.round(5).should == 3.46E-3
    calculator.minus
    calculator.value.round(5).should == 179.99654
    calculator.times
    calculator.value.round(4).should == 66598.7198
    calculator.divide
    calculator.value.round(16).should == 0.0375382591062959
  end

  it "resolves operator precedence unambiguously" do
    # 1 2 + 3 * => (1 + 2) * 3
    calculator.push(1)
    calculator.push(2)
    calculator.plus
    calculator.push(3)
    calculator.times
    calculator.value.should == (1+2)*3

    # 1 2 3 * + => 1 + (2 * 3)
    calculator.push(1)
    calculator.push(2)
    calculator.push(3)
    calculator.times
    calculator.plus
    calculator.value.should == 1+(2*3)
  end

  it "fails informatively when there's not enough values stacked away" do
    expect {
      calculator.plus
    }.to raise_error("calculator is empty")

    expect {
      calculator.minus
    }.to raise_error("calculator is empty")

    expect {
      calculator.times
    }.to raise_error("calculator is empty")

    expect {
      calculator.divide
    }.to raise_error("calculator is empty")
  end

  # extra credit
  it "tokenizes a string" do
    calculator.tokens("1 2 3 * + 4 5 - /").should ==
      [1, 2, 3, :*, :+, 4, 5, :-, :/]
  end

  # extra credit
  it "evaluates a string" do
    calculator.evaluate("1 2 3 * +").should ==
      ((2 * 3) + 1)

    calculator.evaluate("4 5 -").should ==
      (4 - 5)

    calculator.evaluate("2 3 /").should ==
      (2.0 / 3.0)

    calculator.evaluate("1 2 3 * + 4 5 - /").should ==
      (1.0 + (2 * 3)) / (4 - 5)

    calculator.evaluate("1.3 2.5 3.7 * + 4.2 5.25 - /").should ==
      (1.3 + (2.5 * 3.7)) / (4.2 - 5.25)

    calculator.evaluate("1.12E-2 2.27E1 3.5E2 * + 4.2E3 5.64E2 - /").should ==
      (1.12E-2 + (2.27E1 * 3.5E2)) / (4.2E3 - 5.64E2)
  end

end
