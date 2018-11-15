module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_schema
        @committee_schema ||= Committee::Drivers.load_from_file(Rails.root.join('docs', 'schema', 'schema.json').to_s)
      end

      def committee_options
        if defined?(RSpec) && (options = RSpec.try(:configuration).try(:committee_options))
          options
        else
          {schema: committee_schema}
        end
      end

      def request_object
        request
      end

      def response_data
        [response.status, response.headers, response.body]
      end
    end
  end
end
