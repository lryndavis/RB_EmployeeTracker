class Employee < ActiveRecord::Base
  belongs_to(:divisions)
  belongs_to(:projects)
end
