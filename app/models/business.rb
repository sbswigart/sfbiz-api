class Business < ApplicationRecord
  has_many :favorite

  scope :close_to, -> (lon, lat, distance_in_meters = 20 * 1609.34) {
    select(sanitize_sql_array([%{
      ST_Distance(
        lonlat,
        ST_GeomFromText('POINT(? ?)',4326)
      ) AS distance,
      *
    }, lon, lat])).
    where([%{
      ST_DWithin(
        lonlat,
        ST_GeographyFromText('SRID=4326;POINT(? ?)'),
        ?
      )
    }, lon, lat, distance_in_meters]).
    order("1")
  }

  module Factories
    GEO = RGeo::Geographic.spherical_factory(:srid => 4326)
  end
  before_create :set_lonlat

  def longitude
    long
  end
  def latitude
    lat
  end
  def lonlat
    Factories::GEO.point(longitude, latitude)
  end

  def distance
    self[:distance]
  end

  private
  def set_lonlat
    unless longitude.nil? && latitude.nil?
      self.lonlat = Factories::GEO.point(longitude, latitude)
    end
  end
end
