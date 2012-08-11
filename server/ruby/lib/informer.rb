require 'net/smtp'

class Informer
  def send message, to, opts = {}
    opts[:server]      ||= 'smtp.gmail.com'
    opts[:from]        ||= 'email@example.com'
    opts[:from_alias]  ||= 'Example Emailer'
    opts[:subject]     ||= 'You need to see this'
    opts[:body]        ||= 'Important stuff!'

    message = "Subject: Test\n\nThis works"
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', 'spencerkward@gmail.com', 'atheistg', :login) do
      smtp.send_message message, 'spencerkward@gmail.com', to
    end
  end
end
