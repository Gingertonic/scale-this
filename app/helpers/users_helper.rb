module UsersHelper
  def last_practised(period)
    content_tag(:h3, "Last practised #{period}")
  end

  def period_class(period)
    period.gsub(" ","_").gsub('!','')
  end

  def p_for_scale(practise)
    content_tag(:p, link_to(practise.scale.name, show_scale_path({scale_slug: practise.scale.name, root_note: 60})))
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
