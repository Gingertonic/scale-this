module ScalesHelper
  def of_type(scales, type)
    @scales.select{|s|s.scale_type == type}
  end

  def li_for_scale(s)
    content_tag(:li, link_to(s.name, show_scale_path({scale_slug: s.slugify, root_note: "do"})))
  end
end
