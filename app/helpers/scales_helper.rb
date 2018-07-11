module ScalesHelper
  def of_type(scales, type)
    @scales.select{|s|s.scale_type == type}
  end

  def scale_title(scale)
    content_tag(:h1, "#{@scale.name.titleize}")
  end

  def li_for_scale(s)
    content_tag(:li, link_to(s.name, show_scale_path({scale_slug: s.slugify, root_note: "do"})))
  end

  def ownership(owner)
    if current_user.id == owner.id
      content_tag(:h2, "Thanks for contributing this scale!")
    elsif owner.admin == false
      content_tag(:h2, "Contributed by #{owner.name}")
    end
  end

  def div_for_sequencer(value, i)
    content_tag(:div, "#{Note.midi_to_solfege(value).first}", class: ["pitch"], id: ["pitch_#{i}"], style: "background-color: #F#{value*26}0")
  end

  def div_for_alt_pitch(value, i)
    content_tag(:div, "#{Note.midi_to_solfege(value).second}", class: ["alt-pitch"], id: ["alt-pitch_#{i}"])
  end

  def scale_info(scale)
      content_tag(:p, "Melody Rules: #{@scale.melody_rules}") +
      content_tag(:p, "Origin: #{@scale.origin}") +
      content_tag(:p, "Type: #{@scale.scale_type}") +
      if @scale.aka
        content_tag(:p, "Also known as: #{@scale.aka}")
      end
  end

  def delete_scale_form(scale, owner)
    if owner.id == current_user.id
      form_for(scale, :html => {:method => :delete}) do |f|
        f.submit "Delete this scale"
      end
    end
  end


end
