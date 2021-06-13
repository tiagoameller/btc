# Patterns: Service Object; Template Method; Factory Method
module Services
  # Report Services are called from controllers
  class Report < Services::Object
    # context is an optional hash of concrete parameters for concrete reports
    # rubocop:disable Lint/MissingSuper
    def initialize(controller, context = {})
      @controller = controller
      @helpers = controller.helpers
      @context = context
    end
    # rubocop:enable Lint/MissingSuper

    def call
      validate
      execute unless errors.any?
    end

    private

    # validate is used here as a factory method pattern
    # heirs will have their own validate
    def validate
      report_name = @controller.params['report']
      case report_name
      when 'month'
        @report = Services::Reporters::PdfMonth
      when 'year'
        @report = Services::Reporters::PdfYear
      else
        errors.add('report', "Undefined report: '#{report_name}'")
      end
    end

    # execute is used here to call a concrete report
    # heirs will have their own execute
    def execute
      request = @report.send(:call, @controller, @context)
      errors.add_multiple_errors(request.errors) if request.failure?
      request
    end
  end
end
