<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Employee Registration Form</title>
<style type="text/css">
span.error {
	color: red;
	margin-left: 5px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('button[type=submit]').click(
				function(e) {
					e.preventDefault();
					$('input').next().remove();
					$.post({
						url : 'saveEmployee',
						data : $('form[name=employeeForm]').serialize(),
						success : function(res) {
							if (res.validated) {
								$('#resultContainer pre code').text(
										JSON.stringify(res.employee));
								$('#resultContainer').show();
							} else {
								$.each(res.errorMessages, function(key, value) {
									$('input[name=' + key + ']').after(
											'<span class="error">' + value
													+ '</span>');
								});
							}
						}
					})
				});
	});
</script>
</head>
<body>
	<h1>Employee Input Form</h1>
	<hr />

	<form action="saveEmployee" method="post" name="employeeForm">
		<table>
			<tr>
				<td>First Name</td>
				<td><input name="firstName" type="text" /></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input name="lastName" type="text" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input name="email" type="text" /></td>
			</tr>
			<tr>
				<td>Designation</td>
				<td><input name="designation" type="text" /></td>
			</tr>
			<tr>
				<td></td>
				<td><button type="submit">Submit</button></td>
			</tr>
		</table>
	</form>

	<!-- Result Container  -->
	<div id="resultContainer" style="display: none;">
		<hr />
		<h4 style="color: green;">JSON Response From Server</h4>
		<pre style="color: green;">
    <code></code>
   </pre>
	</div>
</body>
</html>