require 'crack'
require 'base64'

class TileMap
  
  attr_reader :props, :enemies, :player
  def initialize(map_file)
    @tiles = {}
    data = Crack::XML.parse(File.read(File.join(DATA_ROOT,"levels","#{map_file}.tmx")))
    Ary(data['map']['tileset']).each {|tset| load_tiles(tset) }
    @width, @height = data['map']["width"].to_i, data['map']["height"].to_i
    layers = hashify(data["map"]["layer"])
    @map_data = decode(layers["Terrain"]["data"]).map {|gid| @tiles[gid] }
    object_groups = hashify(data["map"]["objectgroup"])
    @props = Ary(object_groups["Props"]["object"]).map {|o_dfn| TMapObject.new(o_dfn) }
    @enemies = Ary(object_groups["Enemies"]["object"]).map {|o_dfn| TMapObject.new(o_dfn) }
    @player = TMapObject.new(object_groups["Player"]["object"])  
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
  
  def decode(data)
    Base64.decode64(data).unpack("V*")
  end
  
  def hashify(group)
    ary = Ary(group)
    hsh = {}
    ary.each {|entry| hsh[entry["name"]] = entry }
    hsh
  end
    
end


Tile = Struct.new(:image,:tag,:passable) do
  def add_property(key,value)
    self[key.to_sym] = value
  end
  
  def passable?(passer)
    case passable
    when true, false then passable
    when nil then Terrain[tag].passable?(passer)
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

class TMapObject
  attr_reader :type, :properties, :x, :y
  def initialize(dfn)
    dfn = dfn.dup
    @type = dfn.delete("type") || "prop"
    @x = (dfn.delete("x").to_i / TILE_WIDTH) - 1
    @y = (dfn.delete("y").to_i / TILE_WIDTH) - 1
    @properties = dfn
  end
end