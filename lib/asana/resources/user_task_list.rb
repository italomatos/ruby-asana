require_relative 'gen/user_task_lists_base'

module Asana
  module Resources
    # A _user task list_ represents the tasks assigned to a particular user. It provides API access to a user's "My Tasks" view in Asana.
    #
    # A user's "My Tasks" represent all of the tasks assigned to that user. It is
    # visually divided into regions based on the task's
    # [`assignee_status`](/developers/api-reference/tasks#field-assignee_status)
    # for Asana users to triage their tasks based on when they can address them.
    # When building an integration it's worth noting that tasks with due dates will
    # automatically move through `assignee_status` states as their due dates
    # approach; read up on [task
    # auto-promotion](/guide/help/fundamentals/my-tasks#gl-auto-promote) for more
    # infomation.
    class UserTaskList < UserTaskListsBase


      attr_reader :gid

      attr_reader :resource_type

      attr_reader :name

      attr_reader :owner

      attr_reader :workspace

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'user_task_lists'
        end

        # Returns the full record for the user task list for the given user
        #
        # user - [String] An identifier for the user. Can be one of an email address,
        # the globally unique identifier for the user, or the keyword `me`
        # to indicate the current user making the request.
        #
        # workspace - [Gid] Globally unique identifier for the workspace or organization.
        #
        # options - [Hash] the request I/O options.
        def find_by_user(client, user: required("user"), workspace: required("workspace"), options: {})
          params = { workspace: workspace }.reject { |_,v| v.nil? || Array(v).empty? }
          Resource.new(parse(client.get("/users/#{user}/user_task_list", params: params, options: options)).first, client: client)
        end

        # Returns the full record for a user task list.
        #
        # id - [Gid] Globally unique identifier for the user task list.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/user_task_lists/#{id}", options: options)).first, client: client)
        end
      end

      # Returns the compact list of tasks in a user's My Tasks list. The returned
      # tasks will be in order within each assignee status group of `Inbox`,
      # `Today`, and `Upcoming`.
      #
      # **Note:** tasks in `Later` have a different ordering in the Asana web app
      # than the other assignee status groups; this endpoint will still return
      # them in list order in `Later` (differently than they show up in Asana,
      # but the same order as in Asana's mobile apps).
      #
      # **Note:** Access control is enforced for this endpoint as with all Asana
      # API endpoints, meaning a user's private tasks will be filtered out if the
      # API-authenticated user does not have access to them.
      #
      # **Note:** Both complete and incomplete tasks are returned by default
      # unless they are filtered out (for example, setting `completed_since=now`
      # will return only incomplete tasks, which is the default view for "My
      # Tasks" in Asana.)
      #
      # completed_since - [String] Only return tasks that are either incomplete or that have been
      # completed since this time.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def tasks(completed_since: nil, per_page: 20, options: {})
        params = { completed_since: completed_since, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/user_task_lists/#{gid}/tasks", params: params, options: options)), type: Task, client: client)
      end

    end
  end
end
