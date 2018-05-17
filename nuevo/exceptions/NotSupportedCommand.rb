class NotSupportedCommand < Exception
  def message
    'Invalid command. Use help for command list'
  end
end