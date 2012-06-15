################################################################################
# $Id: reports_controller.rb 1720 2009-12-10 16:39:14Z ccaroon $
################################################################################
require 'bluecloth';
require 'date';

class ReportsController < ApplicationController

    respond_to :html;
    ############################################################################
    def by_day
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');

        @report = Report.new(:by_day, date);
        @report.run();
        
        render_report();
    end
    ############################################################################
    def by_category
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');

        @report = Report.new(:by_category, date);
        @report.run();
        
        render_report();
    end
    ############################################################################
    def summary
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');
        
        @report = Report.new(:summary, date);
        @report.run();
        
        render_report();
    end
    ############################################################################
    def extended_summary
        start_date = Date.strptime(params[:start_date], '%Y%m%d');
        end_date   = Date.strptime(params[:end_date], '%Y%m%d');

        @report = Report.new(:extended_summary, start_date, end_date);
        exclude_cats = [Entry::CATEGORY_CODE_REVIEW, Entry::CATEGORY_MEETING,
            Entry::CATEGORY_OTHER];
        @report.run(:exclude_categories => exclude_cats);

        render_report();
    end
    ############################################################################
    def send_email_report
        type = params[:type];
        date = (params[:date].nil? || params[:date].empty?) ? Date.today : Date.strptime(params[:date], '%Y%m%d');

        report = Report.new(type.to_sym, date);
        report.run();

        ReportMailer.weekly(report).deliver;

        redirect_to :controller => 'main', :action => 'home';
    end
    ############################################################################
    private
    ############################################################################
    def render_report
        markdown = BlueCloth.new(render_to_string(:layout => false));

        respond_to do |format|
            format.html {render :layout => false, :text => markdown.to_html}
        end
    end
end
