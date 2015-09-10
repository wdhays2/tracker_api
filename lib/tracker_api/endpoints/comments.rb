module TrackerApi
  module Endpoints
    class Comments
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, story_id, params={})
        data = client.paginate("/projects/#{project_id}/stories/#{story_id}/comments", params: params)
        raise Errors::UnexpectedData, 'Array of comments expected' unless data.is_a? Array

        data.map do |comment|
          Resources::Comment.new({ story_id: story_id }.merge(comment))
        end
      end

      def for_epic(project_id, epic_id, params={})
        data = client.paginate("/projects/#{project_id}/epics/#{epic_id}/comments", params: params)
        raise Errors::UnexpectedData, 'Array of comments expected' unless data.is_a? Array

        data.map do |comment|
          Resources::Comment.new({ epic_id: epic_id }.merge(comment))
        end
      end

      def for_story(project_id, story_id, params={})
        get(project_id, story_id, params)
      end
    end
  end
end