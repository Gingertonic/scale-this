class Practise < ApplicationRecord
  belongs_to :musician
  belongs_to :scale

  def increase_experience #increase the experience value by 1
    experience += 1
    save
  end

  def status #returns when the practise last happened
    if easy_read(updated_at) == today
      'today'
    elsif easy_read(updated_at) == yesterday
      'yesterday'
    elsif last_practised.to_i >= this_week
      'this week'
    elsif last_practised.to_i >= last_month
      'this month'
    elsif last_practised.to_i < last_month
      'ages ago!'
    end
  end

  private
  def last_practised
    updated_at.to_i
  end

  def today
    easy_read(Time.now)
  end

  def yesterday
    easy_read(Time.now - 1.day)
  end

  def this_week
    (Time.now - 1.week).to_i
  end

  def last_month
    (Time.now - 1.month).to_i
  end

  def easy_read(datetime) 
    datetime.strftime("%A %B%e %Y")
  end
end
