/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@SuppressWarnings("PMD.UseUtilityClass")
public class DateUtils {
	
	public static Integer differenceInMonths(long start, long end) {
		return differenceInMonths(new Date(start), new Date(end));
	}
	public static Integer differenceInMonths(Date beginningDate, Date endingDate) {
        if (beginningDate == null || endingDate == null) {
            return 0;
        }
        return differenceIn(beginningDate, endingDate, false);
    }

	public static Integer differenceInWeeks(long start, long end) {
		return differenceIn(new Date(start), new Date(end), true);
	}
	public static Integer differenceIn(Date beginningDate, Date endingDate, boolean weeks) {
        if (beginningDate == null || endingDate == null) {
            return 0;
        }
        Date sanitaryBeginning = generalizeTime(beginningDate);
        Date sanitaryEnding = generalizeTime(endingDate, true);
        Calendar start = new GregorianCalendar();
        start.setTime(sanitaryBeginning);
        int diff = 0;
        int type = weeks ? Calendar.WEEK_OF_YEAR : Calendar.MONTH;
        
        while (start.getTime().before(sanitaryEnding)) {
        	start.add(type, 1);
        	diff++;
        }
        //Cause its always off by one too many.
        diff -= 1;

        return diff;
    }
    
	private static Date generalizeTime(Date date) {
		return generalizeTime(date, false);
	}
    private static Date generalizeTime(Date date, boolean ending) {
    	Calendar temp = new GregorianCalendar();
        temp.setTime(date);
        if (ending) {
        	temp.set(Calendar.HOUR_OF_DAY, 1);
        } else {
        	temp.set(Calendar.HOUR_OF_DAY, 0);
        }
        temp.set(Calendar.MINUTE, 0);
        temp.set(Calendar.SECOND, 0);
        temp.set(Calendar.MILLISECOND, 0);
        return temp.getTime();
    }
}
