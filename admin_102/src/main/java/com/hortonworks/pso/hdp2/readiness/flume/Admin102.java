package com.hortonworks.pso.hdp2.readiness.flume;

import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.event.EventBuilder;
import org.apache.flume.interceptor.Interceptor;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class Admin102 implements Interceptor {
    static final Logger logger = Logger.getLogger(Admin102.class.getName());
    private String fileName;

    public Admin102() {

    }

    @Override
    public void initialize() {
        logger.info("Init Admin 102 Interceptor");
    }

    /**
     * Modifies events in-place.
     */
    @Override
    public Event intercept(Event event) {

        try {
            String eventBody = new String(event.getBody(), "UTF-8");
            // Remove Commented Records.  Usually the Header and Trailing Records
            // of an incoming file.
            if (eventBody.charAt(0) == '#') {
                return null;
            }

            // Look for the Filename, which will contain information about
            // Network Element.  Get it from the Filename and add it to the
            // record as the 1st field.
            Map<String, String> map = event.getHeaders();
            String completeFileName = map.get("file");

            //Use String builder to write the new Event.
            StringBuilder builder = new StringBuilder();
            builder.append(eventBody).append(",").append(completeFileName);
            Event e = EventBuilder.withBody(builder.toString(), Charset.forName("UTF-8"));
            return e;

        } catch (Exception exp) {
            logger.warning("Problem with record interceptor: " + exp.getMessage());
            exp.printStackTrace();
            // Pass-through event.
            return event;
        }
    }

    /**
     * Delegates to {@link #intercept(Event)} in a loop.
     *
     * @param events
     * @return
     */
    @Override
    public List<Event> intercept(List<Event> events) {
        List<Event> eventList = new ArrayList<Event>();
        for (Event event : events) {
            Event outEvent = intercept(event);
            if (outEvent != null) {
                eventList.add(outEvent);
            }
        }
        return eventList;
    }

    @Override
    public void close() {
        logger.info("Close FDR Interceptor");
    }

    public static class Builder implements Interceptor.Builder {


        @Override
        public Interceptor build() {
            return new Admin102();
        }


        @Override
        public void configure(Context arg0) {
            // TODO Auto-generated method stub

        }

    }

}
