require 'yaml'

module MediaManager
  class << self
    # def image(name)
    #   @images ||= {}
    #   @images[name] ||= begin
    #                       filename = "#{name}.png"
    #                       path = File.join(MEDIA_ROOT,'images',filename)
    #                       Gosu::Image.new(path, retro: true)
    #                     end
    # end
    #
    # def setup
    #   tilepath = File.join(MEDIA_ROOT,'images','basictiles_2.png')
    #   tiles = Gosu::Image.load_tiles(tilepath,16,16,retro: true)
    # end
  
    def image(name)
      @images ||= {}
      @images[name] ||= _load_image_named(name)
    end
    
    def font(name)
      @fonts ||= {}
      @fonts[name] ||= _load_font_named(name)
    end
    
    def font_path(name)
      @font_paths ||= {}
      @font_paths[name] ||= File.join(MEDIA_ROOT,'fonts',_font_map[name]['path'])
    end
    
    def tileset(name)
      _tiles(name)
    end
    
    def sfx(name)
      @sfx ||= {}
      @sfx[name] ||= _load_sfx_named(name)
    end
    
    def play_sfx(name)
      sfx(name).play(0.5) unless @mute_sfx
    end
    
    def toggle_sfx
      @mute_sfx = !@mute_sfx
    end
    
    def sfx?
      !@mute_sfx
    end
  
    def song(name)
      @songs ||= {}
      @songs[name] ||= _load_song_named(name)
    end
  
    def song_for_level(level)
      case level
      when  0..5  then "oceans"
      when  6..10 then "ghost"
      when 11..20 then "cheese" #TODO: Make fourth song
      else "oceans"
      end
    end
    
    def play_song_for_level(level)
      name = song_for_level(level)
      play_music(name) if music? && Gosu::Song.current_song != song(name)        
    end
  
    def play_music(name=nil)
      name ||= song_for_level($game.level)
      song(name).play(true)
    end
  
    def stop_music
      Gosu::Song.current_song&.stop
    end
    
    def music?
      Gosu::Song.current_song
    end
    
    def toggle_music
      Gosu::Song.current_song ? stop_music : play_music
    end
  
    private  
    
    def _load_sfx_named(name)
      fname = _sfx_map[name] || "#{name}.wav"
      path = File.join(MEDIA_ROOT,"sfx",fname)
      Gosu::Sample.new(path)
    end
    
    def _sfx_map
      @_sfx_map ||= YAML.load_file(File.join(DATA_ROOT,'sfx.yml'))
    end
    
    def _load_song_named(name)
      fname = _song_map[name]
      path = File.join(MEDIA_ROOT,"music",fname)
      song = Gosu::Song.new(path)
      song.volume = 0.75
      song
    end
    
    def _song_map
      @_song_map ||= YAML.load_file(File.join(DATA_ROOT,'music.yml'))
    end
    
    def _pick_random_song
      _song_map.keys.sample
    end
    
    def _load_font_named(name)
      data = _font_map[name]
      path = File.join(MEDIA_ROOT,'fonts',data['path'])
      Gosu::Font.new(data['size'],name: path)
    end
    
    def _font_map
      @_font_map ||= YAML.load_file(File.join(DATA_ROOT,'fonts.yml'))
    end
  
    def _load_image_named(name)
      data = _mapping[name]
      if data.has_key?('set')
        _tiles(data['set'])[data['index']]
      elsif data.has_key?('image')
        path = File.join(MEDIA_ROOT,'images',data['image'])
        Gosu::Image.new(path,retro: true)
      end
    end
  
    def _mapping
      @_mapping ||= YAML.load_file(File.join(DATA_ROOT,'tileset.yml'))
    end
  
    def _tiles(set)
      @_tiles ||= {}
      @_tiles[set] ||= _load_tiles(set)
    end
  
    def _load_tiles(set)
      path = File.join(MEDIA_ROOT,'tilesets',set)
      Gosu::Image.load_tiles(path,32,32,retro: true)
    end
  end
  
end