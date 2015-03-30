module CoursesHelper

  def star(num)

    data = ""
    if num > 0
      num = num.to_i
      num.times { data+= "<i class='fa fa-star star'></i> " } 
      data.html_safe
    else
      data = "<i class='fa fa-star-half-o'></i> <span>(None)</span>"
      data.html_safe
    end
  end

  def rocket(num)
    
    data = ""

    if num > 0
      num = num.to_i
      num.times { data+= "<i class='fa fa-rocket rocket'></i>  " } 
      data.html_safe
    else
      data = "<i class='fa fa-rocket'></i> <span>(None)</span>"
      data.html_safe
    end

  end

end
