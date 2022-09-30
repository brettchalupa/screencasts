class User < ApplicationRecord
  def commit_author
    "#{name} <#{email}>"
  end
end
