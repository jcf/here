class Location < NSManagedObject
  # property :creation_date, NSDateAttributeType
  # property :latitude, NSDoubleAttributeType
  # property :longitude, NSDoubleAttributeType

  ATTRIBUTES = {
    creation_date: NSDateAttributeType,
    latitude: NSDoubleAttributeType,
    longitude: NSDoubleAttributeType
  }

  def self.entity
    # Create the entity for our Location class. The entity has 3 properties.
    # CoreData will appropriately define accessor methods for the properties.

    @entity ||= begin
      NSEntityDescription.alloc.init.tap do |entity|
        entity.name = 'Location'
        entity.managedObjectClassName = 'Location'

        entity.properties = ATTRIBUTES.map do |name, type|
          NSAttributeDescription.alloc.init.tap do |property|
            property.name = name.to_s
            property.attributeType = type
            property.optional = false
          end
        end
      end
    end
  end
end
