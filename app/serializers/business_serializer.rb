class BusinessSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :start_date, :end_date
end
