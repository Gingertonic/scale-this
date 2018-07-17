module UsersHelper
  def last_practised(period)
    content_tag(:h3, "Last practised #{period}")
  end

  def period_class(period)
    period.gsub(" ","_").gsub('!','')
  end

  def p_for_scale(practise)
    if practise.scale
      content_tag(:p, link_to(practise.scale.name, show_scale_path({scale_slug: practise.scale.slugify, root_note: "do"})))
    else
      content_tag(:p, link_to("A scale that was removed from the library!", scales_path))
    end
  end

  def total_practise(m)
    total_exp = 0
    m.practises.each do |p|
      total_exp += p.experience
    end
    total_exp
  end

  def last_practice_time(m)
    if total_practise(m) != 0
      m.practises.last.updated_at.strftime("%D")
    else
      "Not once! Shocking!"
    end
  end

end

# EXPERIMENTS!

#   def print_practise_log(period, scales)
#     content_tag :div, class: ["practised", "#{period}"] do
#       concat(
#         content_tag(:h3, "Last practised #{period}") +
#         content_tag(:div, "#{list_scales(scales)}", class: ["scales_list"])
#       )
#     end
#   end
#
  # def list_scales(scales)
  #   scales.collect do |practise|
  #     p_for_scale(practise)
  #   end
  # end
#


    # <p><%=link_to practise.scale.name, scale_path({scale_slug: practise.scale.name, root_note: 60})%> - Experience: <%=practise.experience%></p>
#
#   def say_hello(name)
#     content_tag(:p, "Hello, #{name}!", class: ["awesome", "cool", "#{name}"])
#   end
# end

# <%= content_tag :div, class: "strong" do -%>
#   Hello world!
# <% end -%>
 # => <div class="strong">Hello world!</div>


# content_tag(:h3, "Last practised #{period}")
# scales.each do |practise|
#   content_tag(:p, link_to practise.scale.name)
# end

# content_tag(:div, "Hello world!", class: ["strong", "highlight"])
