class ProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :brand_ids

  def brand_ids
    object.brands.map(&:id)
  end
end
