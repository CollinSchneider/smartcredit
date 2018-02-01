module InstanceVariableHelper
  def set_instance_variables(args)
    # use with caution
    # sets instance variables in included class to the key name
    # @accounts = args[:accounts]
    return unless args.is_a?(Hash)
    args.each { |key, val| instance_variable_set(formatted_key(key), val) }
  end

  private
  def formatted_key(key)
    "@#{key.to_s}".to_sym
  end
end