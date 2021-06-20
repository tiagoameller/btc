# Patterns: Service Object; Template Method; Factory Method
module Services
  # Report Services are called from controllers
  class GraphData < Services::Object
    attr_reader :messages

    def call
      validate
      return if errors.any?

      @labels = []
      @usd_average = []
      @gbp_average = []
      @eur_average = []
      @current_time = Time.current

      execute
      return if errors.any?

      @result = {
        labels: @labels,
        x_title: @x_title,
        usd: {
          min_max: @usd_min_max,
          average: @usd_average
        },
        gbp: {
          min_max: @gbp_min_max,
          average: @gbp_average
        },
        eur: {
          min_max: @eur_min_max,
          average: @eur_average
        }
      }
    end

    private

    # heirs will have their own validate
    def validate
      # add errors if not validate
    end
  end
end
