require "spec_helper"

class Array
  def rmap
    new_array = []
    self.each do |item|
      new_array.push(yield(item))
    end
    new_array
  end

  def rmap!
    self.each_with_index do |item, index|
      self[index] = yield(item)
    end
  end
end

RSpec.describe Array do
  describe "#rmap" do
    it "returns a new array of the elements with executed block" do
      original_array = [1, 2, 3]
      new_array = original_array.rmap do |item|
        item * 2
      end

      expect(new_array).to eql([2, 4, 6])
      expect(original_array).to eql([1, 2, 3])
    end

    it "works with the pretzel syntax" do
      names = [double(name: "Brett"), double(name: "Chet")].rmap(&:name)

      expect(names).to eql(["Brett", "Chet"])
    end
  end

  describe "#rmap!" do
    it "modifies the elements in the array with the executed block" do
      array = [1, 2, 3]

      returned_array = array.rmap! do |item|
        item * 2
      end

      expect(array).to eql([2, 4, 6])
      expect(returned_array).to eql(array)
    end
  end
end
