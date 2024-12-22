<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
    String n1 = (String) session.getAttribute("patientlogin");
    if (n1 != null) {
        out.println("Welcome " + n1);
        %>
        <br><br>
        <script>
            function goToURL() {
                window.location.href = "patienthelp.jsp";
            }
        </script>
         <label onclick="goToURL()" style="cursor: pointer; color: blue; text-decoration: underline;">Get Doctor Advice</label>
         <form action="plogout.jsp" method="post">
         <input type="submit" value="Logout">
         </form>
         <%
        } else {
        out.println("No user is logged in.");
    }
    %>
</body>
</html>
