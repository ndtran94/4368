<%@page contentType="text/html" pageEncoding="utf-8"%>

<html lang="en">
<head>
<!--
"Time-stamp: <Sun, 03-13-16, 22:16:59 Eastern Daylight Time>"
//-->
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="My online portfolio that illustrates skills acquired while working through various project requirements.">
	<meta name="author" content="Mark K. Jowett, Ph.D.">
	<link rel="icon" href="favicon.ico">

	<title>CRSXXXX - Assignment4</title>

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
	
    <h3>Thanks for joining our customer list!</h3>

    <p>Here is the information that you entered:</p>


    <label>First Name:</label> ${user.firstName}<br />
    <label>Last Name:</label> ${user.lastName}<br />
    <label>Email:</label> ${user.email}<br />
    <label>Street:</label> ${user.street}<br />
    <label>City:</label>${user.city}<br/>
    <label>State:</label>${user.state}<br/>
    <label>ZipCode:</label>${user.zip}<br/>
    <label>Phone:</label>${user.phone}<br/>
    <label>Balance:</label>${user.balance}<br/>
    <label>Total Sales:</label>${user.sales}<br/>
    <label>Notes:</label>${user.notes}<br/>

    <p>To enter another email address, click on the Back 
    button in your browser or the Return button shown 
    below.</p>

    <form action="" method="post">
      <input type="hidden" name="action" value="join">
      <input type="submit" value="Return">
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

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
		
</body>
</html>
