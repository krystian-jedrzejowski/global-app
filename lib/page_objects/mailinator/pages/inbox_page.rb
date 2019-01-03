module PageObjects::Mailinator::Pages
  class InboxPage < PageObjects::Mailinator::Page
    set_url '/v3/index.jsp?zone=public&query={email}#/#inboxpane'

    sections :global_app_emails, 'tbody>tr[id^=row_]' do
      element :from, :xpath, './td[3]'
      element :subject, :xpath, './td[4]'
    end

    def find_email(subject)
      global_app_emails.find { |email| email.subject.text.eql? subject }
    end

    def open_email(subject)
      find_email(subject).subject.click
    end
  end
end