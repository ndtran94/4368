<!DOCTYPE html>
<html lang="en">
<head>
<!--
"Time-stamp: <Wed, 02-17-16, 20:48:11 Eastern Standard Time>"
//-->
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="My online portfolio that illustrates skills acquired while working through various project requirements.">
	<meta name="author" content="Mark K. Jowett, Ph.D.">
	<link rel="icon" href="favicon.ico">

	<title>CRSXXXX - Project1</title>

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

	<%@ include file="../global/nav.jsp"%>	

	<div class="container">
		<div class="starter-template">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					
					<div class="page-header">
						<%@ include file="global/header.jsp"%>
					</div>

					<h2>Customers</h2>
					
					<form id="add_customer_form" method="post" class="form-horizontal" action="#">

						<div class="form-group">
							<label class="col-sm-3 control-label">First Name:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="fname" maxlength="15" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Last Name:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="lname" maxlength="30" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Email:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="email" maxlength="100"/>
							</div>
						</div>
						<div class="form-group">
						        <label class="col-sm-3 control-label">Street:</label>
							<div class="col-sm-5">
							     <input type="text" class="form-control" name="street" maxlength="30"/>
							</div>     
						</div>
						<div class="form-group">
						        <label class="col-sm-3 control-label">City:</label>
							<div class="col-sm-5">
							     <input type="text" class="form-control" name="city" maxlength="30"/>
							</div>  
						</div>  
						
						<div class="form-group">
						        <label class="col-sm-3 control-label">State:</label>
							<div class="col-sm-5">
							    <input type="text" class="form-control" name="state" maxlength="2"/>
							</div>
						</div>
						<div class="form-group">
						       <label class="col-sm-3 control-label">Zip:</label>
						       <div class="col-sm-5">
							    <input type="text" class="form-control" name="zipcode" maxlength="9"/>
						       </div>	    
						</div>
						<div class="form-group">
						       <label class="col-sm-3 control-label">Phone:</label>
						       <div class="col-sm-5">
							   <input type="text" class="form-control" name="phone" maxlength="10"/>
						       </div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Balance:</label>
							<div class="col-sm-5">
							<input type="text" class="form-control" name="balance" maxlength="7"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Total Sales:</label>
							<div class="col-sm-5">
							<input type="text" class="form-control" name="sales" maxlength="7"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Notes:</label>
							<div class="col-sm-5">
							<input type="text" class="form-control" name="notes" maxlength="100"/>
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
	<%@ include file="global/footer.jsp"%>

	</div> <!-- end starter-template -->
 </div> <!-- end container -->

	<!-- Bootstrap JavaScript
	================================================== -->
	<!-- Placed at end of document so pages load faster -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- Turn off client-side validation, in order to test server-side validation.  -->
<script type="text/javascript" src="js/formValidation/formValidation.min.js"></script>

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
									
					email: {
							validators: {
									notEmpty: {
											message: 'Email address is required'
									},
									stringLength: {
											min: 1,
											max: 100,
											message: 'Email no more than 100 characters'
									},
									regexp: {
									regexp: /^([A-Za-z0-9_\.-]+)@([\da-zA-Z\.-]+)\.([a-zA-Z\.]{2,6})$/,
										message: 'Must include valid email'
									},											
							},
					},
					street: {
							validators: {
									notEmpty: {
											message: 'street required'
									},
									stringLength: {
											min: 1,
											max: 30,
											message: 'max 30 characters'
									},
									regexp: {
										//http://www.regular-expressions.info/
										//http://www.regular-expressions.info/quickstart.html
										//http://www.regular-expressions.info/shorthand.html
										//http://stackoverflow.com/questions/13283470/regex-for-allowing-alphanumeric-and-space
										//alphanumeric (also, "+" prevents empty strings):
										regexp: /^([A-Za-z0-9\, _]*[A-Za-z0-9\,\.][A-Za-z0-9\.\, _])*$/,
										message: 'may contain only letters, numbers, periods, commas and white spaces'
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
											message: 'max 30 characters'
									},
									regexp: {
										regexp: /^([A-Za-z0-9\,\. _]*[A-Za-z0-9][A-Za-z0-9\,\. _])*$/,
										message: 'can contain only letters and numbers'
									},									
							},
					},
					state: {
							validators: {
									notEmpty: {
											message: 'State required'
									},
									stringLength: {
											min: 1,
											max: 2,
											message: 'max 2 characters'
									},
									regexp: {
										regexp: /^[a-zA-Z\-]+$/,
										message: 'in "FL" format. Only letters'
									},									
							},
					},
					zipcode: {
						validators: {
									notEmpty: {
											message: 'zipcode required'
									},
									stringLength: {
											min: 5,
											max: 9,
											message: 'min 5 digits, max 9 digits'
									},
									regexp: {
										regexp: /^([0-9])+$/,
										message: 'only numbers accepted'
									},									
							},
					},
					phone: {
						validators: {
							notEmpty: {
								message: 'phone number required'
							},
							stringLength: {
								min:10,
								max:10,
								message: 'must be 10 digits, including zipcode'
							},
							regexp: {
								regexp: /^([1-9]{1}[0-9]{9})*$/,
								message: 'must only contain numbers. must be 10 digits, including zipcode. Cannot start with a 0'
							
							},
						},
					},
					balance: {
							validators: {
							notEmpty: {
								message: 'balance required'
							},
							stringLength: {
								min:1,
								max:7,
								message: 'format $9999.99'
							},
							regexp: {
								//regexp: /^[0-9][0-9]\.{0,2}+$/,
								regexp: /^([0-9])+(\.?)([0-9][0-9])+$/,
								message: 'must only contain numbers and be rounded to 2 decimal places'
							},
						},
					},
					sales: {
							validators: {
							notEmpty: {
								message: 'total sales required'
							},
							stringLength: {
								min:1,
								max:7,
								message: 'format $9999.99'
							},
							regexp: {
								//regexp: /^[0-9][0-9]\.{0,2}+$/,
								regexp: /^([0-9])+(\.?)([0-9][0-9])+$/,
								message: 'must only contain numbers and be rounded to 2 decimal places'
							},
						},
					},
						notes: {
							validators: {
							
							stringLength: {
								min:1,
								max:100,
								message: '100 character max!'
							},
							regexp: {
								//regexp: /^([A-Za-z0-9\,\. _)*$/,
								regexp: /^[a-zA-Z0-9~@#\^\$&\*\(\)%<>-_\+=\[\]\{\}\|\\,\.\?\!\s]*$/,
								message: 'optional notes!:)'
							},
						},
					},		
			}
	});
});
</script>

</body>
</html>
