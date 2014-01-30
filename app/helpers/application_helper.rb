module ApplicationHelper

  def show_params
    html = "<div style='border:1px red solid'>"
    html += "<h5>Params Hash</h5>"
    params.each do |key,value|
      html += "#{key} : #{value}<br/>" if key != 'authenticity_token' && key != 'utf8'
    end
    html += "</div>"
    return html.html_safe
  end
end
