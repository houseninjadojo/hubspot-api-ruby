module Hubspot
  #
  # HubSpot LineItem API
  #
  # {https://legacydocs.hubspot.com/docs/methods/line-items/line-items-overview}
  #
  class LineItem < Hubspot::Resource
    self.id_field = "objectId"
    self.update_method = "post"
    self.property_name_field = "name"

    ALL_PATH                = '/crm-objects/v1/objects/line_items'
    CREATE_PATH             = '/crm-objects/v1/objects/line_items'
    DELETE_PATH             = '/crm-objects/v1/objects/line_items/:id'
    FIND_PATH               = '/crm-objects/v1/objects/line_items/:id'
    UPDATE_PATH             = '/crm-objects/v1/objects/line_items/:id'
    # BATCH_UPDATE_PATH       = '/crm-objects/v1/objects/line_items/batch-update'

    # @todo
    # get properties
    # &properties=name&properties=price&properties=quantity

    class << self
      def all(opts = {})
        Hubspot::PagedCollection.new(opts) do |options, offset, limit|
          response = Hubspot::Connection.get_json(
            ALL_PATH,
            options.merge(offset: offset, limit: limit)
          )

          line_items = response["objects"].map { |result| from_result(result) }

          [line_items, response["offset"], response["has-more"]]
        end
      end

      def find_by_id(id)
        response = Hubspot::Connection.get_json(FIND_PATH, id: id)
        new(response)
      end
    end
  end
end
