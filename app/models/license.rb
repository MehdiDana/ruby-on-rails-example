class License < ActiveRecord::Base
  belongs_to :driver
set_inheritance_column :ruby_type
end

class CodeB < License
end


class CodeC1 < License
end


class CodeC < License 
end
