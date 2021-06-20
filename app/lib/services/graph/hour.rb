module Services
  module Graph
    class Hour < Services::GraphData
      private

      def execute
        59.downto(0) do |i|
          minute = @current_time - i.minutes
          @labels << minute.strftime('%M')
          average = Rates::Average.minute(minute)
          @usd_average << average.usd
          @gbp_average << average.gbp
          @eur_average << average.eur
        end
        @x_title = 'Minutes'
        @usd_min_max = Rates::MinMax.usd(@current_time - 1.hour, @current_time)
        @gbp_min_max = Rates::MinMax.gbp(@current_time - 1.hour, @current_time)
        @eur_min_max = Rates::MinMax.eur(@current_time - 1.hour, @current_time)
      end
    end
  end
end
