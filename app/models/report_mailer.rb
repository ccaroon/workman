################################################################################
# $Id: report_mailer.rb 2236 2010-12-13 21:27:33Z ccaroon $
################################################################################

REPORT_TO = [%w(wkreiling@mcclatchyinteractive.com sschnorr@mcclatchyinteractive.com)];
REPORT_CC = [%w(developers@mcclatchyinteractive.com)];

class ReportMailer < ActionMailer::Base

    def weekly(report)
        subject    "[WR] #{(report.end_date-1).strftime("%Y.%m.%d")}";
        recipients REPORT_TO;
        cc         REPORT_CC;
        from       User.user.email;
        sent_on    Time.now;
        content_type "text/html";

        body       :report => report;
    end

end
