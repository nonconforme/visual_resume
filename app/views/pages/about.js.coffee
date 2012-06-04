$("#page").html("<%= escape_javascript(render(:template => "pages/about", :formats => :html)) %>").fadeIn(1000)
document.title = "Nick J. Reed | About"