module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/customer
  # 100  Invalid customer data. Details in error message.
  # 101  Invalid filters specified. Details in error message.
  # 102  Customer does not exist.
  # 103  Customer not deleted. Details in error message.
  class Customer < Base
    extend Magento::Helpers::Crud

    def addresses
      Magento::CustomerAddress.list(self.id)
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
