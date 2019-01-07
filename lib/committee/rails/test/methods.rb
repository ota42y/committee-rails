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
        schema = if RSpec.configuration.committee_schema_json
                   Committee::Drivers::load_from_json(RSpec.configuration.committee_schema_json)
                 elsif RSpec.configuration.committee_schema_yaml
                   Committee::Drivers::load_from_yaml(RSpec.configuration.committee_schema_yaml)
                 end

        { schema: schema }
      end
    end
  end
end
