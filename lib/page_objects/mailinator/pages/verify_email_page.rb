module PageObjects::Mailinator::Pages
  class VerifyEmailPage < PageObjects::Mailinator::Page
    set_url '/v3/index.jsp?zone=public&query={email}#/#msgpane'

    element :msg_body_iframe, '#msg_body'
    element :confirm_button, 'a', text: 'Confirm Now'

    load_validation { has_msg_body_iframe? }

    def confirmation_link
      within_frame(msg_body_iframe) do
        return confirm_button['href']
      end
    end

    def confirmation_token
      confirmation_link.split('/')[-1]
    end
  end
end