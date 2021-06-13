module HasBreadcrumbs
  extend ActiveSupport::Concern

  included do
    before_action :set_breadcrumbs
    helper_method :breadcrumbs

    def breadcrumbs
      @breadcrumbs ||= []
    end

    def add_breadcrumbs(ary)
      ary.each do |a|
        breadcrumbs << { label: a.first, url: a.second }
      end
    end

    def add_breadcrumb(label, url = nil)
      add_breadcrumbs [[label, url]]
    end
  end
end
