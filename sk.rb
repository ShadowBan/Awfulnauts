class Sk

  def self.get_list(list_id,owner_id=nil)
    is_owner = false
    list = settings.cache.get(list_id)
    is_owner = true if owner_id && list[:owner_id] == owner_id.to_i  
    return list,is_owner
  end

  def self.add_raider(list_id,name)
    list = settings.cache.get(list_id)
    raider = {:roll=>Random.rand(100), :loot_count=>0, :name=> name}
    if already_loot? list
      list = add_to_looted_list list, raider
    else
      list = add_to_new_list list, raider
    end
    settings.cache.set(list_id, list, 604800)
  end

  def self.remove_raider(list_id,name)
    list = settings.cache.get(list_id)
    list[:raiders].delete_if{|r| r[:name] == name}
    settings.cache.set(list_id, list, 604800)
  end
  
  def self.get_loot(list_id,name)
    list = settings.cache.get(list_id)
    lr = list[:raiders].select{|r| r[:name] == name}.first rescue nil
    unless lr.nil?
      list[:raiders].delete(lr)
      lr[:loot_count] += 1
      list[:raiders] << lr
      settings.cache.set(list_id, list, 604800)
    end
  end

  def self.roll_all(list_id)
    list = settings.cache.get(list_id)
    names = list[:raiders].collect{|r|r[:name]}
    names.collect{|n|{:name=>n,:roll=>Random.rand(100)}}.sort_by{|a|a[:roll]} rescue nil
  end

  def self.create_list
    list = {:raiders=>[],:owner_id=>Random.rand(100000)}
    list_id = Random.rand(100000)
    settings.cache.set(list_id, list, 604800)
    return list_id, list[:owner_id]
  end

  private

  def self.already_loot?(list)
    lc = list[:raiders].select{|r| r[:loot_count] > 0}
    if lc.count > 0
      return true
    else
      return false
    end
  end

  def self.add_to_new_list(list, raider)
    list[:raiders] << raider
    list[:raiders] = list[:raiders].sort_by{|a|a[:roll]}
    list
  end

  def self.add_to_looted_list(list, raider)
    noloot = list[:raiders].select{|r| r[:loot_count] == 0}
    noloot << raider
    list[:raiders] = (noloot.sort_by{|a|a[:roll]}) + (list[:raiders].delete_if{|r| noloot.include? r})
    list
  end

end