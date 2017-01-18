require "pg"
require_relative "orm"

orm = Orm.new("vadim","7286","testdb")

#orm.create_sequence("slack")
#orm.create_table("block")

array = Array.new
array[1] = 1
array[0] = "try_this"

items_to_update = {:name => "name", :old_value => "'try_this'", :new_value => "'new_try'"}
#items_to_del = {:name => "name", :value => "'try_this'"}

#orm.add_items("block", array)
#orm.delete_items("block", items_to_del)
#orm.update_items("block", items_to_update)
orm.get_items("block")

