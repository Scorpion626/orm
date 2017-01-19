require "pg"
require_relative "orm"
require_relative "block"

options = {:user => "vadim", :password => "7286", :dbname => "testdb"}
#orm = Orm.new(options)

#orm.create_sequence
#orm.create_table("blocks")

array = Array.new
array[1] = 1
array[0] = "try_this"

items_to_update = {:name => "name", :old_value => "try_this", :new_value => "new_try"}
items_to_del = {:name => "name", :value => "new_try"}

#orm.add_items("block", array)
#orm.delete_items("block", items_to_del)
#orm.update_items("block", items_to_update)
#orm.get_items("block")


#block = Block.new(options)
#block.create
#block.get_item
#block.add_item(array)
#block.get_item
#block.update_item(items_to_update)
#block.get_item
#block.delete_item(items_to_del)
#block.get_item
Block.conn(options)
Block.create(array)
Block.select_all
Block.update(items_to_update)
Block.select_all
Block.delete(items_to_del)
Block.select_all
Block.close_connection


