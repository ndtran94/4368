<%@ page import="java.util.GregorianCalendar, java.util.Calendar" %>
<%  
    GregorianCalendar currentDate = new GregorianCalendar();
    int currentYear = currentDate.get(Calendar.YEAR);
%>
&copy; <%= currentYear %> My Footer, Inc.
