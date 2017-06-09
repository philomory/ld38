module Settings
  DEFAULTS = { 
    max_completed_level: 0,
    music: true,
    sfx: true,
    fullscreen: false,
    input: InputManager.defaults
  }.freeze
    
  SETTINGS = DEFAULTS.dup
  
  module_function
  
  def load
    begin
      SETTINGS.merge!(YAML.load_file(SETTINGS_FILE))
    rescue
      save
    end
  end
  
  def save
    File.open(SETTINGS_FILE, 'w' ) do |out|
      YAML.dump(SETTINGS,out)
    end
  end
  
  def load_defaults
    SETTINGS.replace(DEFAULTS)
  end
  
  def [](key)
    SETTINGS[key]
  end
  
  def []=(key,value)
    if value != SETTINGS[key]
      SETTINGS[key] = value
    end
  end
  
  def set_key_path(*path_and_value)
    *init, last, value = *path_and_value
    SETTINGS.dig(*init)[last] = value
    save
  end
      
end
