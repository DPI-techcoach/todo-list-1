# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  description :text
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class List < ApplicationRecord
end
