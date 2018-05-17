class CorruptedFile < Exception
  def message
    "Error: The file is corrupted"
  end
end
