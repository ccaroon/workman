################################################################################
# $Id: application_helper.rb 1337 2008-09-05 16:15:24Z ccaroon $
################################################################################
module ApplicationHelper
    
    def streamlined_footer
        return "Craig N. Caroon"
    end
    
    def streamlined_top_menus
        theme = 'default';
        [
            ["<img src='/images/themes/#{theme}/home.png' title='Home' border='0'>",
                {:controller => 'main', :action => 'home'}],
            ["<img src='/images/themes/#{theme}/entries.png' title='Entries' border='0'>",
                {:controller => 'entries'}],
            ["<img src='/images/themes/#{theme}/hours.png' title='Hours' border='0'>",
                {:controller => 'work_days'}],
            ["<img src='/images/themes/#{theme}/goals.png' title='Goals' border='0'>",
                {:controller => 'goals'}],
            ["<img src='/images/themes/#{theme}/todos.png' title='Todos' border='0'>",
                {:controller => 'todos'}],
            ["<img src='/images/themes/#{theme}/notes.png' title='Notes' border='0'>",
                {:controller => 'notes'}],
            ["<img src='/images/themes/#{theme}/user_stories.png' title='User Stories' border='0'>",
                {:controller => 'user_stories'}],
            ["<img src='/images/themes/#{theme}/weekly_report.png' title='Weekly Report' border='0'>",
                {:controller => 'reports', :action => 'by_category'}],
        ]
    end
    
    def streamlined_side_menus
        [
            ["New Entry",    {:controller => 'entries',   :action => 'new'}],
            ["New Goal",     {:controller => 'goals',     :action => 'new'}],
            ["New Todo",     {:controller => 'todos',     :action => 'new'}],
            ["New Note",     {:controller => 'notes',     :action => 'new'}],
            ["Gen Hours",    {:controller => 'work_days', :action => 'generate_week'}],
        ]
    end
    
    def streamlined_branding

        avatar  = 'avatar1.png';
        name    = '';
        pref_id = nil;
        if (session[:user_id])
            # TODO: don't hit db everytime.
            user    = User.find(session[:user_id]);

            user_id = user.id;
            name    = user.name;
            avatar  = user.pref.avatar;
            # For some reason user.pref.id causes 'Stack too deep' error
            pref_id = user.pref_id;
        end

        effect  = visual_effect(:toggle_blind, 'user_menu', {:duration => 0.5});
        effect2 = visual_effect(:highlight, "user_name", {:duration => 1.00, :startcolor => '#003399', :endcolor=>'#2175bc'});
        sign_out_link = '<a href="/users/logout">Signout</a>';

        js_func =<<EOF;
function do_effects()
{
    #{effect}
    #{effect2}
}
EOF

        return <<EOF;
<script language="javascript">
#{js_func}
</script>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td align="left"><img border='0' src='/images/themes/default/logo.png'></td>
        
        <td align="right" valign="bottom">
            <img src="/images/themes/default/#{avatar}" border="0" align="absbottom">
            <a id="user_name" href=javascript:do_effects()>#{name}</a>
            <div id="user_menu" style="display:none;font-size:10pt">
                <a href="/users/edit/#{user_id}">Edit</a>
                |
                <a href="/prefs/edit/#{pref_id}">Prefs</a>
                |
                #{sign_out_link}
            </div>
        </td>
    </tr>
</table>
EOF
    end
    
    def breadcrumb
        return false;
    end
end
