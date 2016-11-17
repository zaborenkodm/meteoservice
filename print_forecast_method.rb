# encoding: utf-8

# словарик состояний параметра cloudiness, описанный на сайте метеосервиса
CLOUDINESS = {0 => 'Ясно', 1 => 'Малооблачно', 2 => 'Облачно', 3 => 'Пасмурно'}

# словарик времени суток, описанный на сайте метеосервиса
TIME_OF_DAY = {0 => 'ночь', 1 => 'утро', 2 => 'день', 3 => 'вечер'}

# Метод, выводящий данные для заданного REXML тэга
# forecast_rexml_node - объект REXML парсера, содержащий тег <FORECAST>
# current_time - текущее время, относительно которого выводится прогноз
def print_forecast(forecast_rexml_node, current_time)
  # достаем из XML дату прогноза
  day = forecast_rexml_node.attributes['day']
  month = forecast_rexml_node.attributes['month']
  year = forecast_rexml_node.attributes['year']
  tod = TIME_OF_DAY[forecast_rexml_node.attributes['tod'].to_i]

  # записываем мин. и макс. температуру из вложенного тэга TEMPERATURE
  min_temp = forecast_rexml_node.elements['TEMPERATURE'].attributes['min']
  max_temp = forecast_rexml_node.elements['TEMPERATURE'].attributes['max']

  # записываем макс. ветер из вложенного тэга WIND
  max_wind = forecast_rexml_node.elements['WIND'].attributes['max']

  # достали из PHENOMENA атрибут cloudiness и по его значению — состояние облаков из словарика
  clouds = CLOUDINESS[forecast_rexml_node.elements['PHENOMENA'].attributes['cloudiness'].to_i]

  puts

  # Проверяем если это текущие данные, не нужно писать полную дату
  if current_time.day == day.to_i && current_time.month == month.to_i
    puts "Сегодня, #{tod}"
  else
    puts "#{day}.#{month}.#{year}, #{tod}"
  end

  puts "#{min_temp}..#{max_temp}, ветер #{max_wind} м/с, #{clouds}"
end
