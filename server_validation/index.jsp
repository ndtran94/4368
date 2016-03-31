
<!DOCTYPE html>
<html lang="en">
<head>
<!--
"Time-stamp: <Sun, 03-13-16, 22:00:54 Eastern Daylight Time>"
//-->
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="My online portfolio that illustrates skills acquired while working through various project requirements.">
	<meta name="author" content="Mark K. Jowett, Ph.D.">
	<link rel="icon" href="favicon.ico">

	<title>LIS4368 - Assignment4</title>

<!-- Include FontAwesome CSS to use feedback icons provided by FontAwesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<!-- Bootstrap for responsive, mobile-first design. -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">

<!-- Form validation styling. -->
<link rel="stylesheet" href="css/formValidation.min.css"/>

<!-- Starter template for individual styling. -->
<link href="css/starter-template.css" rel="stylesheet">

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>
<body>

	<%@ include file="global/nav.jsp" %>	

	<div class="container">
		<div class="starter-template">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					
					<div class="page-header">
						<%@ include file="global/header.jsp" %>
					</div>

					<h2>Customers</h2>
					<h5>again...</h5>
					<p><i>${message}</i></p>

					<form id="add_customer_form" method="post" class="form-horizontal" action="customerList">

						<input type="hidden" name="action" value="add">						
						
						<div class="form-group">
							<label class="col-sm-3 control-label">FName:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="15" name="fname" value="${customer.fname}" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">LName:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="30" name="lname" value="${customer.lname}" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Street:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="30" name="street" value="${customer.street}" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">City:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="30" name="city" name-"city" value="${customer.city}"/>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">State:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="2" name="state" value="${customer.state}"/>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Zip:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="9" name="zip" value="${customer.zip}" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Phone:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="10" name="phone" value="${customer.phone}" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Email:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="100" name="email" value="${customer.email}" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Balance:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="7" name="balance" value="${customer.balance}" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Total Sales:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="7" name="sales" value="${customer.sales}" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Notes:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" maxlength="255" name="notes" value="${customer.notes}" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<button type="submit" class="btn btn-primary" name="signup" value="Sign up">Submit</button>
							</div>
						</div>
					</form>
				</div>
			</div>

	<%@ include file="global/footer.jsp" %>

	</div> <!-- end starter-template -->
 </div> <!-- end container -->

	<!-- Bootstrap JavaScript
	================================================== -->
	<!-- Placed at end of document so pages load faster -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- Turn off client-side validation, in order to test server-side validation.  -->
<!-- <script type="text/javascript" src="js/formValidation/formValidation.min.js"></script>  -->

<!-- Note the following bootstrap.min.js file is for form validation, different from the one above. -->
<script type="text/javascript" src="js/formValidation/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>

<script type="text/javascript">
$(document).ready(function() {

	$('#add_customer_form').formValidation({
			message: 'This value is not valid',
			icon: {
					valid: 'fa fa-check',
					invalid: 'fa fa-times',
					validating: 'fa fa-refresh'
			},
			fields: {

				fname: {
							validators: {
									notEmpty: {
											message: 'First name required'
									},
									stringLength: {
											min: 1,
											max: 15,
											message: 'First name no more than 15 characters'
									},
									regexp: {
										//http://www.regular-expressions.info/
										//http://www.regular-expressions.info/quickstart.html
										//http://www.regular-expressions.info/shorthand.html
										//http://stackoverflow.com/questions/13283470/regex-for-allowing-alphanumeric-and-space
										//alphanumeric (also, "+" prevents empty strings):
										regexp: /^[a-zA-Z\-]+$/,
										message: 'First name can only contain letters and hyphens'
									},									
							},
					},

				lname: {
							validators: {
									notEmpty: {
											message: 'Last name required'
									},
									stringLength: {
											min: 1,
											max: 30,
											message: 'Last name no more than 30 characters'
									},
									regexp: {
										regexp: /^[a-zA-Z\-]+$/,
										message: 'Last name can only contain letters and hyphens'
									},									
							},
					},
				
					street: {
							validators: {
									notEmpty: {
											message: 'Street required'
									},
									stringLength: {
											min: 1,
											max: 30,
											message: 'Street no more than 30 characters'
									},
									regexp: {
										//street: only letters, numbers, comma, space character, and period
										regexp: /^[a-zA-Z0-9,\s\.]+$/,		
									message: 'Street can only contain letters, numbers, commas, or periods'
									},									
							},
					},
 					
					city: {
							validators: {
									notEmpty: {
											message: 'City required'
									},
									stringLength: {
											min: 1,
											max: 30,
											message: 'City no more than 30 characters'
									},
									regexp: {
										regexp: /^[a-zA-Z\-\s]+$/,																				
										message: 'City can only contain letters and hyphen'
									},									
							},
					},
					
					state: {
							validators: {
									notEmpty: {
											message: 'State required'
									},
									stringLength: {
											min: 2,
											max: 2,
											message: 'State must be two characters'
									},
									regexp: {
										regexp: /^[a-zA-Z]+$/,
										message: 'State can only contain letters'
									},									
							},
					},
					
					zip: {
							validators: {
									notEmpty: {
											message: 'Zip required, only numbers'
									},
									stringLength: {
											min: 5,
											max: 9,
											message: 'Zip must be 5, and no more than 9 digits'
									},
									regexp: {
										regexp: /^[0-9]+$/,
										message: 'Zip can only contain numbers'
									},									
							},
					},
					
					phone: {
							validators: {
									notEmpty: {
											message: 'Phone required, including area code, only numbers'
									},
									stringLength: {
											min: 10,
											max: 10,
											message: 'Phone must be 10 digits'
									},
									regexp: {
										regexp: /^[0-9]+$/,
										message: 'Phone can only contain numbers'
									},									
							},
					},
					
					email: {
							validators: {
									notEmpty: {
											message: 'Email address is required'
									},

									/*
									//built-in e-mail validator, comes with formValidation.min.js
									//using regexp instead (below)
									emailAddress: {
											message: 'Must include valid email address'
									},
									*/
								
									stringLength: {
											min: 1,
											max: 100,
											message: 'Email no more than 100 characters'
									},
									regexp: {
									regexp: /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,
										message: 'Must include valid email'
									},																		
							},
					},

					balance: {
							validators: {
									notEmpty: {
											message: 'Balance is required'
									},
									stringLength: {
											min: 1,
											max: 7,
											message: 'Balance can be no more than 6 digits, including decimal point'
									},
									regexp: {
										regexp: /^[0-9\.]+$/,
										message: 'Balance can only contain numbers and decimal point'
									},									
							},
					},
					
					total_sales: {
							validators: {
									notEmpty: {
											message: 'Total sales is required'
									},
									stringLength: {
											min: 1,
											max: 7,
											message: 'Total sales can be no more than 6 digits, including decimal point'
									},
									regexp: {
										regexp: /^[0-9\.]+$/,
										message: 'Total sales can only contain numbers and decimal point'
									},									
							},
					},
			}
	});
});
</script>

</body>
</html>
