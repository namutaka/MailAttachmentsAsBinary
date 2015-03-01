require 'redmine'
require 'mail_handler_patch'


Redmine::Plugin.register :mail_attachments_as_binary do
  name 'Mail Attachments As Binary plugin'
  author 'namutaka'
  description 'Received mail attachments save as binary.'
  version '0.0.1'
  url 'https://github.com/namutaka/mail-attachments-as-binary'
end


Rails.configuration.to_prepare do

  unless MailHandler.included_modules.include?(MailAttachmentsAsBinary::MailHandlerPatch)
    MailHandler.send(:include, MailAttachmentsAsBinary::MailHandlerPatch)
  end

end

