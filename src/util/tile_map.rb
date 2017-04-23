require 'crack'
require 'base64'

class TileMap
  
  def initialize(map_file)
    @tiles = {}
    data = Crack::XML.parse(File.read(File.join(DATA_ROOT,"levels","#{map_file}.tmx")))
    Ary(data['map']['tileset']).each {|tset| load_tiles(tset) }
    @width, @height = data['map']["width"].to_i, data['map']["height"].to_i
    @map_data = Base64.decode64(Ary(data["map"]["layer"]).first["data"]).unpack("V*").map {|gid| @tiles[gid] }
  end
  
  def [](x,y)
    @map_data[x + y * @width]
  end
  
  
  private
  def load_tiles(tset)
    ImageManager.tileset(tset["image"]["source"].split("/").last).each_with_index do |image,index|
      register_tile(index+tset["firstgid"].to_i, Tile.new(image))
    end
    Ary(tset["tile"]).each {|props| set_tile_properties(props,tset["firstgid"]) } 
  end
  
  def register_tile(gid, tile)
    @tiles[gid] = tile
  end
  
  def set_tile_properties(props,first_gid)
    gid = props["id"].to_i + first_gid.to_i
    dfns = Ary(props["properties"]["property"])
    tile = @tiles[gid]
    dfns.each {|dfn| tile.add_property(dfn["name"],dfn["value"]) }
  end
    
end


Tile = Struct.new(:image,:tag,:passable) do
  def add_property(key,value)
    self[key.to_sym] = value
  end
  
  def passable?
    case passable
    when true, false then passable
    when nil then Terrain[tag].passable?
    else raise ArgumentError
    end
  end
  
  def method_missing(name,*args,&blk)
    proto = Terrain[tag]
    proto.respond_to?(name) ? proto.send(name,*args,&blk) : super
  end
  
  def draw(xpos,ypos)
    image.draw(xpos,ypos,0)
  end
end