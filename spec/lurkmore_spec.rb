require 'rspec'
require_relative('../lib/lurkmore')

describe Lurkmore do
  it 'should print random article' do
    Lurkmore.random
  end
end