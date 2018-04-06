module GraphHelper
  def temperatures_by_day
    line_chart @days.map {|day| [day.number, day.temp] }, 
      title: {text: ''},
      yAxis: {
        min: 95,
        allowDecimals: true,
        title: {
          text: 'Temperature'
        }
      },
      xAxis: {
        title: {
          text: 'Cycle day number'
        }
      }
  end
end
