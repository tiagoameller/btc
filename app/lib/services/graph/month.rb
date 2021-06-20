module Services
  module Graph
    class Month < Services::GraphData
      private

      def execute
        29.downto(0) do |i|
          day = @current_time - i.days
          @labels << day.strftime('%d')
          average = Rates::Average.day(day)
          @usd_average << average.usd
          @gbp_average << average.gbp
          @eur_average << average.eur
        end
        @x_title = 'Days'
        @usd_min_max = Rates::MinMax.usd(@current_time - 30.days, @current_time)
        @gbp_min_max = Rates::MinMax.gbp(@current_time - 30.days, @current_time)
        @eur_min_max = Rates::MinMax.eur(@current_time - 30.days, @current_time)
      end
    end
  end
end
