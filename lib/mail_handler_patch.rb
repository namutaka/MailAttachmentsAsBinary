# encoding: utf-8
#
# monkey patch for MailHandler
#

module MailAttachmentsAsBinary
  module MailHandlerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :add_attachments, :read
      end
    end

    module InstanceMethods

      def add_attachments_with_read(obj)
        if email.attachments && email.attachments.any?
          email.attachments.each do |attachment|
            next unless accept_attachment?(attachment)
            obj.attachments << Attachment.create(:container => obj,
                              #:file => attachment.decoded,
                              :file => attachment.read,
                              :filename => attachment.filename,
                              :author => user,
                              :content_type => attachment.mime_type)
          end
        end
      end

    end
  end
end

