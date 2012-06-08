################################################################################
# $Id: report_mailer.rb 2236 2010-12-13 21:27:33Z ccaroon $
################################################################################

#REPORT_TO = [%w(wkreiling@mcclatchyinteractive.com sschnorr@mcclatchyinteractive.com)];
#REPORT_CC = [%w(developers@mcclatchyinteractive.com)];

REPORT_TO = [%w(ccaroon@mcclatchyinteractive.com)];
REPORT_CC = [%w(craig-web@caroon.org)];

class ReportMailer < ActionMailer::Base

    def weekly(report)
        mail(:from => User.user.email,
             :to => REPORT_TO,
             :cc => REPORT_CC,
             :content_type => "text/html",
             :subject => "[WR] #{(report.end_date-1).strftime("%Y.%m.%d")}",
             :body => report);
    end

end
