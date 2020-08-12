require 'bound/record_type'

module Bound
  module BuiltinRecordTypes
    class CNAME < Bound::RecordType

      self.type_name = "CNAME"
      self.color = 'f1ad3b'

      def fields
        [
          {:name => 'name', :label => "Canonical Name"}
        ]
      end

      def validate(hash, errors)
        if hash['name']
          if hash['name'].starts_with?('') && hash['name'].ends_with?('.')
            errors << "Data does not need be enclosed in quotes - these are added when exported"
          end
        end
      end

      def serialize(hash)
        data = hash['name']
        if data.blank?
          '@'
        else
          total_length = data.size
          parts, remainder = total_length.divmod(255)
          parts = parts + (remainder > 0 ? 1 : 0)
          array = []
          parts.times do |i|
            array << '' + data[i * 255, 255] + '.'
          end
          array.join(' ')
        end
      end

      def deserialize(string)
        {'name' => string}
      end

    end
  end
end
