module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_options
        @committee_options ||= build_comittee_option
      end

      def request_object
        request
      end

      def response_data
        [response.status, response.headers, response.body]
      end

      private

      def build_comittee_option
        if RSpec.configuration.committee_schema_type == :hyper_schema
          driver = Committee::Drivers::HyperSchema.new
          schema = driver.parse(RSpec.configuration.committee_schema_data)

          { schema: schema }
        elsif RSpec.configuration.committee_schema_type == :open_api_3
          open_api = OpenAPIParser.parse(RSpec.configuration.committee_schema_data)

          { open_api_3: Committee::Drivers::OpenAPI3.new.parse(open_api) }
        end
      end
    end
  end
end
