$("#page").html("<%= escape_javascript(render(:template => "pages/contact", :formats => :html)) %>").fadeIn(1000)
document.title = "Nick J. Reed | Contact"