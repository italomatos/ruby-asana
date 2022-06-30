### WARNING: This file is auto-generated by our OpenAPI spec. Do not
### edit it manually.

require_relative '../../resource_includes/response_helper'

module Asana
  module Resources
    class AttachmentsBase < Resource

      def self.inherited(base)
        Registry.register(base)
      end

      class << self
        # Delete an attachment
        #
        # attachment_gid - [str]  (required) Globally unique identifier for the attachment.
        # options - [Hash] the request I/O options
        # > opt_fields - [list[str]]  Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
        # > opt_pretty - [bool]  Provides “pretty” output. Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
        def delete_attachment(client, attachment_gid: required("attachment_gid"), options: {})
          path = "/attachments/{attachment_gid}"
          path["{attachment_gid}"] = attachment_gid
          parse(client.delete(path, options: options)).first
        end

        # Get an attachment
        #
        # attachment_gid - [str]  (required) Globally unique identifier for the attachment.
        # options - [Hash] the request I/O options
        # > opt_fields - [list[str]]  Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
        # > opt_pretty - [bool]  Provides “pretty” output. Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
        def get_attachment(client, attachment_gid: required("attachment_gid"), options: {})
          path = "/attachments/{attachment_gid}"
          path["{attachment_gid}"] = attachment_gid
          Attachment.new(parse(client.get(path, options: options)).first, client: client)
        end

        # Get attachments from an object
        #

        # parent - [str]  (required) Globally unique identifier for object to fetch statuses from. Must be a GID for a task or project_brief.
        # options - [Hash] the request I/O options
        # > offset - [str]  Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
        # > limit - [int]  Results per page. The number of objects to return per page. The value must be between 1 and 100.
        # > opt_fields - [list[str]]  Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
        # > opt_pretty - [bool]  Provides “pretty” output. Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
        def get_attachments_for_object(client, parent: nil, options: {})
          path = "/attachments"
          params = { parent: parent }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get(path, params: params, options: options)), type: Attachment, client: client)
        end

      end
    end
  end
end
