require 'oas_parser'

module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_options
        @committee_options ||= {
            open_api_3: Committee::Drivers::OpenAPI3.new.parse(OasParser::Definition.resolve(Rails.root.join('open_api_3', 'schema.yml')))
          }
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
