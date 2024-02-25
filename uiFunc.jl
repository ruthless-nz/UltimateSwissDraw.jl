using Mousetrap

# define widget colors
const WidgetColor = String
const WIDGET_COLOR_DEFAULT = "default"
const WIDGET_COLOR_ACCENT = "accent"
const WIDGET_COLOR_SUCCESS = "success"
const WIDGET_COLOR_WARNING = "warning"
const WIDGET_COLOR_ERROR = "error"

# create CSS classes for all of the widget colors
for name in [WIDGET_COLOR_DEFAULT, WIDGET_COLOR_ACCENT, WIDGET_COLOR_SUCCESS, WIDGET_COLOR_WARNING, WIDGET_COLOR_ERROR]
    # compile CSS and append it to the global CSS style provider state
    add_css!("""
    $name:not(.opaque) {
        background-color: @$(name)_fg_color;
    }
    .$name.opaque {
        background-color: @$(name)_bg_color;
        color: @$(name)_fg_color;
    }
    """)
end

# function to set the accent color of a widget
function set_accent_color!(widget::Widget, color, opaque = true)
    if !(color in [WIDGET_COLOR_DEFAULT, WIDGET_COLOR_ACCENT, WIDGET_COLOR_SUCCESS, WIDGET_COLOR_WARNING, WIDGET_COLOR_ERROR])
        log_critical("In set_color!: Color ID `" * color * "` is not supported")
    end    
    add_css_class!(widget, color)
    if opaque
        add_css_class!(widget, "opaque")
    end
end


"""
produces a hbox of buttons. Can use varargs to hide buttons.
ideally the button that takes you to the page that you are on should be hidden

varargs are:
    home
    standings
    runDraw
    previousResults
    info

to hide a button, 

MenuButtons(home = false)

"""
function MenuButtons(;
    save = true,
    # download = true,
    home = true,
    standings = true,
    runDraw = true,
    previousResults = true,
    info = true,
)


buttonBox = hbox()

    if save
        # And lets look at the Current round
        saveButton = Mousetrap.Button()
        set_margin!(saveButton, 10)
        set_child!(saveButton, Mousetrap.Label("💾"))

        set_accent_color!(saveButton, WIDGET_COLOR_ACCENT, true)

        connect_signal_clicked!(saveButton) do self::Mousetrap.Button
            println("Saving Swiss Draw")

            file_chooser = FileChooser(FILE_CHOOSER_ACTION_SAVE)
            filter = FileFilter("SwissDraw")
            add_allowed_suffix!(filter, "swissdraw")
            add_filter!(file_chooser, filter)
    
            on_accept!(file_chooser) do self::FileChooser, files::Vector{FileDescriptor}
                _savePath = get_path(files[1])
                println(_savePath)
    
                save_object(_savePath, _swissDrawObject)
            end
    
            present!(file_chooser)
            return nothing
        end

        push_back!(buttonBox,saveButton)
    end 


    if home
        # And lets look at the Current round
        homeButton = Mousetrap.Button()
        set_margin!(homeButton, 10)
        set_child!(homeButton, Mousetrap.Label("homeButton"))

        connect_signal_clicked!(homeButton) do self::Mousetrap.Button

            activate!(homePage)
            println("home")
            return nothing
        end

        push_back!(buttonBox,homeButton)
    end 

    if standings

        # And lets look at the Current round
        standingsButton = Mousetrap.Button()
        set_margin!(standingsButton, 10)
        set_child!(standingsButton, Mousetrap.Label("standingsButton"))

        connect_signal_clicked!(standingsButton) do self::Mousetrap.Button

            # activate!(refreshCurrentDraw)
            println("standings")
            return nothing
        end

        push_back!(buttonBox,standingsButton)


    end 

    if runDraw

        # And lets look at the Current round
        runDrawButton = Mousetrap.Button()
        set_margin!(runDrawButton, 10)

        set_child!(runDrawButton, Mousetrap.Label("runDrawButton"))

        connect_signal_clicked!(runDrawButton) do self::Mousetrap.Button

            # activate!(refreshCurrentDraw)
            println("runDraw")
            return nothing
        end

        push_back!(buttonBox,runDrawButton)

    end     
    
    if previousResults

        # And lets look at the Current round
        previousResultsButton = Mousetrap.Button()
        set_margin!(previousResultsButton, 10)
        set_child!(previousResultsButton, Mousetrap.Label("previousResultsButton"))

        connect_signal_clicked!(previousResultsButton) do self::Mousetrap.Button

            # activate!(refreshCurrentDraw)
            println("previousResults")
            return nothing
        end

        push_back!(buttonBox,previousResultsButton)

    end 

    if info

        # And lets look at the Current round
        infoButton = Mousetrap.Button()
        set_margin!(infoButton, 10)
        set_child!(infoButton, Mousetrap.Label("infoButton"))

        connect_signal_clicked!(infoButton) do self::Mousetrap.Button

            # activate!(refreshCurrentDraw)
            println("info")
            return nothing
        end

        push_back!(buttonBox,infoButton)

    end 

    set_horizontal_alignment!(buttonBox, ALIGNMENT_CENTER)
    set_vertical_alignment!(buttonBox, ALIGNMENT_END)

    return buttonBox

end

# MenuButtons()