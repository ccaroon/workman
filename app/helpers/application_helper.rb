################################################################################
# $Id: application_helper.rb 1734 2009-12-16 21:40:57Z ccaroon $
################################################################################
module ApplicationHelper

    THEME = "default";
    MONTHS = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    ############################################################################
    def date_select(name, datetime = Time.now)

        options = {:month => {}, :day => {}, :year => {}};
        if (!datetime.nil?)
            options[:month][:selected] = datetime.month;
            options[:day][:selected]   = datetime.day;
            options[:year][:selected]  = datetime.year;
        end

        i = 0;
        choices = MONTHS.collect { |m| [ m, i=i+1] };
        choices.unshift(['--', nil]);
        html = select(name, "month", choices,
            {:selected => options[:month][:selected]});

        choices = [];
        1.upto(31) {|d| choices.push([d,d])};
        choices.unshift(['--', nil]);
        html += select(name, "day", choices,
            {:selected => options[:day][:selected]});

        choices = [];
        (Time.now.year-2).upto(Time.now.year+2) {|y| choices.push([y,y])};
        choices.unshift(['--', nil]);
        html += select(name, "year", choices,
            {:selected => options[:year][:selected]});

        # todo[due_on] --> todo_due_on
        # todo[due_on][month] --> todo_due_on_month
        element_id_prefix = name.gsub(/[\[\]]/,' ');
        element_id_prefix.rstrip!;
        element_id_prefix.gsub!(/\s+/, '_');

        html += <<EOF
    <input type="button" value="Today" onClick="date_select_today('#{element_id_prefix}')">
    <input type="button" value="None"  onClick="date_select_none('#{element_id_prefix}')">
EOF

        return (html);
    end
    ############################################################################
    def action_image_tag(action, width=nil, height=nil)
        options = {:title=>action.to_s.capitalize, :border=>'0'};
        options[:width] = width if width;
        options[:height] = height if height;

        return (image_tag("themes/#{THEME}/#{action}.png", options));
    end
    ############################################################################
    def top_menus
        [
            [action_image_tag(:home),    {:controller => 'main', :action => 'home'}],
            [action_image_tag(:entries), {:controller => 'entries'}],
            [action_image_tag(:hours),   {:controller => 'work_days'}],
            [action_image_tag(:goals),   {:controller => 'goals'}],
            [action_image_tag(:lists),   {:controller => 'lists'}],
            [action_image_tag(:todos),   {:controller => 'todos'}],
            [action_image_tag(:notes),   {:controller => 'notes'}],
            [action_image_tag(:countdowns),   {:controller => 'countdowns'}],
            [action_image_tag(:reports), {:controller => 'reports', :action => 'by_category'}],
        ]
    end
    ############################################################################
    def side_menus
        [
            {:action => :entries, :image => action_image_tag(:entries, 20,20)},
            {:action => :goals,   :image => action_image_tag(:goals,20,20)},
            {:action => :todos,   :image => action_image_tag(:todos,20,20)},
            {:action => :notes,   :image => action_image_tag(:notes,20,20)},
        ]
    end
    ############################################################################

end
