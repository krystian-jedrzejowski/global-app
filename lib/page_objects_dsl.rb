module PageObjects
  module DSL
    class PageBinding
      def initialize(page)
        @page = page
      end

      def evaluate(&block)
        @self_before_instance_eval = eval('self', block.binding, __FILE__, __LINE__)
        instance_eval(&block)
      end

      def method_missing(method, *args, &block)
        if @page.respond_to?(method)
          @page.send(method, *args, &block)
        else
          @self_before_instance_eval.send(method, *args, &block)
        end
      end
    end

    def visit_page(page_klass, params = {}, &block)
      page = page_klass.new
      page.load(params)
      expect_url_match(page, params)
      expect(page.loaded?).to be_truthy
      PageBinding.new(page).evaluate(&block) unless block.nil?
    end

    def on_page(page_klass, params = {}, &block)
      page = page_klass.new
      expect_url_match(page, params)
      expect(page.loaded?).to be_truthy
      PageBinding.new(page).evaluate(&block) unless block.nil?
    end

    def expect_url_match(page, params)
      expect(page).to be_displayed(params),
                      "Expected #{current_url} to match: #{page.url_matcher}, params given: #{params}"
    end
  end
end