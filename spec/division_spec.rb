require 'spec_helper'

describe Division do
  describe('#employees') do
    it("tells what employees belong to each devision") do
      test_division = Division.create({:name => "HR"})
      test_employee1 = Employee.create({:name => "Dave", :division_id => test_division.id})
      test_employee2 = Employee.create({:name => "Dave2", :division_id => test_division.id})
     expect(test_division.employees()).to(eq([test_employee1, test_employee2]))
    end
  end
end
