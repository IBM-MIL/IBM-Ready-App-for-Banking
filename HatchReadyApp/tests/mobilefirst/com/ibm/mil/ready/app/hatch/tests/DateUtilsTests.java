/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch.tests;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.junit.Assert;
import org.junit.Test;

import com.ibm.mil.ready.app.hatch.utils.DateUtils;

public class DateUtilsTests {
	@Test
	public void testDifferenceInMonths() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Assert.assertEquals(12, DateUtils.differenceInMonths(sdf.parse("2015/03/22"), 
				sdf.parse("2016/03/22")).intValue());
		Assert.assertEquals(11, DateUtils.differenceInMonths(sdf.parse("2015/01/01"), 
				sdf.parse("2015/12/25")).intValue());
		Assert.assertEquals(87, DateUtils.differenceInMonths(sdf.parse("2015/03/22"), 
				sdf.parse("2022/07/05")).intValue());
		Assert.assertEquals(6, DateUtils.differenceInMonths(sdf.parse("2015/01/22"), 
				sdf.parse("2015/07/22")).intValue());
		Assert.assertEquals(5, DateUtils.differenceInMonths(sdf.parse("2015/01/22"), 
				sdf.parse("2015/06/22")).intValue());
		Assert.assertEquals(17, DateUtils.differenceInMonths(sdf.parse("2015/01/1"), 
				sdf.parse("2016/06/1")).intValue());
    }
	
	@Test
	public void testDifferenceInWeeks() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Assert.assertEquals(52, DateUtils.differenceInWeeks(sdf.parse("2014/03/22").getTime(), 
				sdf.parse("2015/03/22").getTime()).intValue());
		Assert.assertEquals(51, DateUtils.differenceInWeeks(sdf.parse("2014/01/01").getTime(), 
				sdf.parse("2014/12/25").getTime()).intValue());
		Assert.assertEquals(380, DateUtils.differenceInWeeks(sdf.parse("2014/03/22").getTime(), 
				sdf.parse("2021/07/05").getTime()).intValue());
		Assert.assertEquals(25, DateUtils.differenceInWeeks(sdf.parse("2014/01/22").getTime(), 
				sdf.parse("2014/07/22").getTime()).intValue());
    }
}
