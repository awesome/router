require 'lotus/utils/string'
require 'lotus/utils/path_prefix'
require 'lotus/routing/resource'

module Lotus
  module Routing
    class Resources < Resource
      # Action for RESTful resources
      #
      # @since 0.1.0
      #
      # @api private
      #
      # @see Lotus::Router#resources
      class Action < Resource::Action
        # Ruby namespace where lookup for default subclasses.
        #
        # @api private
        # @since 0.1.0
        self.namespace = Resources
      end

      # Collection action
      # It implements #collection within a #resources block.
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class CollectionAction < Resource::CollectionAction
      end

      # Member action
      # It implements #member within a #resources block.
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class MemberAction < Resource::MemberAction
        private
        def path(path)
          prefix.join("/:id/#{ path }")
        end
      end

      # Implementation of common methods for concrete member actions
      #
      # @api private
      # @since 0.1.0
      module DefaultMemberAction
        private
        def rest_path
          "/#{ resource_name }/:id"
        end
      end

      # Index action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Index < Action
        self.verb = :get
      end

      # New action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class New < Resource::New
      end

      # Create action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Create < Resource::Create
      end

      # Show action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Show < Resource::Show
        include DefaultMemberAction
      end

      # Edit action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Edit < Resource::Edit
        include DefaultMemberAction

        private
        def rest_path
          "#{ super }/#{ action_name }"
        end
      end

      # Update action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Update < Resource::Update
        include DefaultMemberAction
      end

      # Destroy action
      #
      # @api private
      # @since 0.1.0
      # @see Lotus::Router#resources
      class Destroy < Resource::Destroy
        include DefaultMemberAction
      end
    end
  end
end
