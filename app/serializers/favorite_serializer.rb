class FavoriteSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :business
end
