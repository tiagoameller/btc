module Services
  module Graph
    class Day < Services::GraphData
      private

      def execute
        23.downto(0) do |i|
          hour = @current_time - i.hours
          @labels << hour.strftime('%H')
          average = Rates::Average.hour(hour)
          @usd_average << average.usd
          @gbp_average << average.gbp
          @eur_average << average.eur
        end
        @x_title = 'Hours'
        @usd_min_max = Rates::MinMax.usd(@current_time - 1.day, @current_time)
        @gbp_min_max = Rates::MinMax.gbp(@current_time - 1.day, @current_time)
        @eur_min_max = Rates::MinMax.eur(@current_time - 1.day, @current_time)
      end
    end
  end
end
