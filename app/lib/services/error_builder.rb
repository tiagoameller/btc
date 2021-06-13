# Patterns: Service Object; Template Method; Factory Method
module Services
  # Report Services are called from controllers
  class ErrorBuilder < Services::Object
    # reasons must be: { error1: ['message1', 'message2', ...], error2: [...] }
    # rubocop:disable Lint/MissingSuper
    def initialize(reasons = {})
      errors.add_multiple_errors(reasons)
    end
    # rubocop:enable Lint/MissingSuper

    def call
      # needed by parent
    end
  end
end
