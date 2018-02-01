# lets keep our custom error classes here! :D
class DateTypeError < StandardError
  def message
    # more specific......
    'Incorrect date class used.'
  end
end