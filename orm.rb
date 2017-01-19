class Orm

  def initialize(options)
    options[:host] = "127.0.0.1"
    @con = PGconn.new(options)
  end

 # def create_sequence
   # @con.exec("CREATE SEQUENCE \"slack\";")
 # end

  private

  def create_table (table_name)
     query = "CREATE TABLE #{table_name} (id INTEGER PRIMARY KEY, name VARCHAR(64));"
    @con.exec(query)
  end

  def add_items(table_name, items)
    prepare_insert(table_name)
    @con.exec_prepared("insert_#{table_name}", [items[0],items[1]])
  end

  def get_items(table_name)
    items = Array.new
    @con.exec("SELECT * FROM #{table_name}") do |result|
      i = result.count - 1
      while (i >= 0)
       items << result[i]
        i -= 1
      end
    end
    p items
  end

  def update_items(table_name, items)
    @con.exec("UPDATE #{table_name} SET #{items[:name]} = #{items[:new_value]}
               WHERE #{items[:name]} = #{items[:old_value]};")
  end

  def delete_items(table_name, element)
    @con.exec("DELETE FROM #{table_name} WHERE #{element[:name]} = #{element[:value]};")
  end

  def delete_table(table_name)
    @con.exec("DROP TABLE IF EXISTS #{table_name}")
  end

  def close_connection
    @con.close
  end

  def prepare_insert(table_name)
    fields = get_table_fields(table_name)
    str = ""
    i =1
    while i <= fields[1]
      unless i == fields[1]
        str+= "($#{i}, "
        i += 1
      else
        str += "$#{i})"
        i += 1
      end
    end
    @con.prepare("insert_#{table_name}", "insert into #{table_name} (#{fields[0]}) values #{str}")
  end

  def get_table_fields(table_name)
    fields = Array.new
    str = ""
    count = 0
    @con.exec("SELECT column_name
               FROM INFORMATION_SCHEMA.COLUMNS
               WHERE table_name = '#{table_name}';") do |result|
      i = result.count - 1
      count = i+1
      while (i >= 0)
        if (i > 0)
          str += result[i]["column_name"] + ", "
          i -= 1

        else
          str += result[i]["column_name"]
          i -=1
        end
      end
    end
    fields[0] = str
    fields[1] = count
    return fields
  end

end