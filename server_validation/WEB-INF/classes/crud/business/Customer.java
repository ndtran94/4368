// save as "<TOMCAT_HOME>\webapps\a4\WEB-INF\classes\crud\business\Customer.java"
package crud.business;

import java.io.Serializable;
import java.lang.*;
public class Customer implements Serializable {

    private String fname;
    private String lname;
    private String email;
    private String street;
    private String city;
    private String state;
    private String notes;
    private int zip;
    private long phone;
    private double balance;
    private double sales;
    
    public Customer() {
        fname = "";
        lname = "";
        email = "";
	street="";
	city="";
	state = "";
	zip = 0;
	phone=0;
      	balance=0.0;
	sales=0.0;
	notes="";
    }

    public Customer(String parFirstName, String parLastName, String parEmail, String parStreet, String parCity,
		    String parState, String parNotes, String parZip , String parPhone, String parBalance, String parSales ) {

	this.setFirstName(parFirstName);
	this.setLastName(parLastName);
	this.setEmail(parEmail);
	this.setStreet(parStreet);
	this.setCity(parCity);
	this.setState(parState);
	this.setNotes(parNotes);
	int tempInt;
	long tempLong;
	double tempDouble;
	tempInt = Integer.valueOf(parZip);
       	this.setZip(tempInt);
	tempLong = Long.parseLong(parPhone);
	this.setPhone(tempLong);
	tempDouble = Double.parseDouble(parBalance);
        this.setBalance(tempDouble);    
	tempDouble = Double.parseDouble(parSales);
	this.setTotalSale(tempDouble);
       
	
    }
    /* accessor */
    public String getFirstName() {
        return this.fname;
    }
    public String getLastName() {
        return this.lname;
    }
    public String getEmail() {
        return this.email;
    }
    
    public String getStreet(){
	return this.street;
    }
    public String getCity(){
	return this.city;
    }
    public String getState(){
	return this.state;
    }
    
    public int getZip(){
	return this.zip;
    }
    public long getPhone(){
	return this.phone;
    }
    public double getBalance(){
	return this.balance;
    }
    public double getTotalSales(){
	return this.sales;
    }
    
    public String getNotes(){
	return this.notes;
    }
   
    /* mutators */
    public void setFirstName(String x) {
        this.fname = x;
    }
    public void setLastName(String x ) {
        this.lname = x;
    }
    public void setEmail(String x ) {
        this.email = x; 
    }
    public void setStreet( String x ){
	this.street = x;
    }
    public void setCity( String x ){
	this.city = x;
    }
    public void setState( String x ){
	this.state = x;
    }
    public void setZip( int x ){
	this.zip = x;
    }
    public void setPhone( long x ){
	this.phone = x;
    }
    public void setBalance( double x ){
	this.balance = x;
    }
    public void setTotalSale( double x ){
        this.sales = x;
    }
    public void setNotes( String x ){
	this.notes = x;
    }



}
