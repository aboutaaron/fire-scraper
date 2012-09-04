module ApplicationHelper
    def link_to(name, options = {}, html_options = {})
        html_options.merge!(:rel => :nofollow)
        super(name, options, html_options)
    end
end
