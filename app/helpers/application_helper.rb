module ApplicationHelper

    def boolean_label(value)
        case value
            when true
                content_tag(:span, value, class: "badge bg-success text-white")
            when false
                content_tag(:span, value, class: "badge bg-danger text-white")
        end
    end
end
