class InvalidArguments < Exception
  def message
    'Invalid arguments. Use help for command list'
  end
end