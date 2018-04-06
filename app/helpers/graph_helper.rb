module GraphHelper
  def temperatures_by_day
    temperature_data = @days.map {|day| [day.number, day.temp] }
    line_chart [
      {
        name: "Temperatures",
        data: temperature_data,
      },
    ],
    library: {
      title: "Temperatures",
      subtitle: "",
      vAxis: {
        viewWindowMode: 'explicit',
          viewWindow: {
          max:100,
          min: 95,
        }
      },
    }
  end

  def other_chars_by_day
    chart_data = [:irritability, :sensitivity, :drinks, :hours_sleep].map do |characteristic|
      data = @days.map {|day| [day.number, day.send(characteristic)] }
      {
        name: characteristic.to_s,
        data: data,
      }
    end
    line_chart chart_data,
    library: {
      title: "Other characteristics",
      subtitle: "",
      legend: "right",
      hAxis: {
        title: 'Cycle Day',
        viewWindowMode: 'explicit',
          viewWindow: {
          max: @days.last.number,
          min: @days.first.number,
        }
      },
    }
  end

  def weight_by_day
    # chart_data = [:irritability, :sensitivity, :drinks, :hours_sleep].map do |characteristic|
      characteristic = :weight
      data = @days.map {|day| [day.number, day.send(characteristic)] }
      chart_data = [
        {
        name: characteristic.to_s,
        data: data,
      },
      ]
    # end
    line_chart chart_data,
    library: {
      title: "Weight",
      subtitle: "",
      vAxis: {
        viewWindowMode: 'explicit',
          viewWindow: {
          max: 150,
          min: 130,
        }
      },
      hAxis: {
        viewWindowMode: 'explicit',
          viewWindow: {
          max: @days.last.number,
          min: @days.first.number,
        }
      },
    }
  end
end
