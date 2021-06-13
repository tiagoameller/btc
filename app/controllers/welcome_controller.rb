class WelcomeController < ApplicationController
  include HasBreadcrumbs

  def index; end

  private

  def set_breadcrumbs
    add_breadcrumbs(
      [
        ['Home', root_path], ['Welcome']
      ]
    )
  end
end
