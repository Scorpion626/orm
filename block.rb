class Block < Orm

  alias_method :create_table, :create_table
  alias_method :add, :add_items
  alias_method :get, :get_items
  alias_method :update_it, :update_items
  alias_method :del, :delete_items
  alias_method :del_tab, :delete_table
  def initialize(options)
    super
    @class_name = class_name
  end

  def create
    create_table(@class_name)
  end

  def add_item(items)
    add(@class_name,items)
  end

  def get_item
    get(@class_name)
  end

  def update_item(items)
    update_it(@class_name, items)
  end

  def delete_item(items)
    del(@class_name, items)
  end

  def del_table
    del_tab(@class_name)
  end



  private
  def class_name
    return self.class.name.to_s.downcase + "s"
  end

end