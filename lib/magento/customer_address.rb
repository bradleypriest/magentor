module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/customer_address
  # 100  Invalid address data. Details in error message.
  # 101  Customer not exists.
  # 102  Address not exists.
  # 103  Address not deleted. Details in error message.
  class CustomerAddress < Base
    extend Magento::Helpers::Crud
    class << self
      # customer_address.create
      # Create customer address
      #
      # Return: int
      #
      # Arguments:
      #
      # int customerId - customer ID
      # array addressData - adress data (country, zip, city, etc...)
      def create(customer_id, attributes)
        id = commit("create", customer_id, attributes)
        record = new(attributes)
        record.id = id
        record
      end
    end

    def country
      Magento::Country.find_by_id(self.country_id)
    end

    def region
      Magento::Region.find_by_country_and_id(self.country_id, self.region_id)
    end

    def update_attribute(name, value)
      @attributes[name] = value
      self.class.update(self.id, Hash[*[name.to_sym, value]])
    end

    def update_attributes(attrs)
      attrs.each_pair { |k, v| @attributes[k] = v }
      self.class.update(self.id, attrs)
    end
  end
end
