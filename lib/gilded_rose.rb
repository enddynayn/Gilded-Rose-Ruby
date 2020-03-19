class GildedRose
  attr_reader :name, :days_remaining, :quality

  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFRAS = "Sulfuras, Hand of Ragnaros"
  CONJURED = "Conjured Mana Cake"

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    return update_generic if generic?

    return if sulfras?
  
    return update_congured if congured?

    return update_backstage_passes if backstage_passes?
  
    return update_aged_brie if aged_brie?
  end

  private
  
  attr_writer :days_remaining

  def decrement_day
    @days_remaining -= 1
  end

  def update_congured
    return decrement_day if quality == 0
    return decrement_day if quality == 0 and days_remaining == 0
    @quality -= 2 if quality == 10 and days_remaining <= 0
    @quality -= 2

    decrement_day
  end

  def update_backstage_passes
    if quality < 50
      @quality += 1 if days_remaining.between?(11, 49)
      @quality += 3 if days_remaining < 6
      @quality += 2 if days_remaining.between?(6, 10)
    end
    
    decrement_day
  
    @quality = 0 if days_remaining < 0
  end

  def update_generic
    @quality -= 1 if @quality > 0
  
    decrement_day

    @quality -= 1 if days_remaining < 0 and @quality > 0
  end

  def update_aged_brie
    @quality += 1 if quality < 50
  
    decrement_day

    @quality += 1 if days_remaining < 0 and quality < 50
  end

  def congured?
    name == CONJURED
  end

  def backstage_passes? 
    name == BACKSTAGE_PASSES
  end

  def aged_brie?
    name == AGED_BRIE
  end

  def sulfras?
    name == SULFRAS
  end

  def generic?
    ![SULFRAS, AGED_BRIE, BACKSTAGE_PASSES, CONJURED].include?(@name)
  end
end
