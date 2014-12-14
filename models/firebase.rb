class FlatironBase
  attr_accessor :base_uri, :data, :table
 
  def initialize(base_uri) 
    @firebase = Firebase::Client.new(base_uri)
    @table = @firebase.get("").body.keys[0] #defaults to first table in database
    puts "Database accessed. Defaulted to first table. (#{@table})"
  end
 
  def swap_table(table_name) #swaps between tables in the database
    @table = table_name
    puts "Active table is now #{@table}"
  end
 
  def add_table(table_name, hash = {"place" => "holder"}) # Creates a table and autoswaps to that table. Firebase doesn't allow for an empty object, so a placeholder hash is needed.
    if @firebase.get("").body.keys.include?(table_name)
      puts "This table already exists. Swapping tables..."
      swap_table(table_name)
    else
      new_table = @firebase.push(table_name, hash)
      swap_table(table_name)
      if new_table.success?
        puts "Table creation success."
      else
        puts "Something went wrong."
        false
      end
    end
  end
 
  def add(table, hash) #adds an entry to the database
    @firebase.push(table, hash)
  end
 
  def get_data #returns an array of all items in the table, defaults to current table in use
    @data = @firebase.get(@table).body
    @data.to_a
  end
 
  def print_data #does what it says on the tin
    puts @data.to_s
  end
 
  def search_by_attribute(attribute, value)
    @data = @firebase.get(@table).body
    @data.each do |data_id, data_values|
      if data_values[attribute] == value
        @id = data_id
      end
    end
    path = "#{@table}/#{@id}"
    @firebase.get(path).body
  end
 
  def remove_by_id(id) #removes an entry in the database by the id
    path = "#{@table}/#{id}"
    @firebase.delete(path)
    puts "Removed '#{path}'"
  end
 
  def remove_table(table_name = @table) #drop a table, defaults to current table
    @firebase.delete(table_name)
    puts "Table deleted."
  end
  
end




