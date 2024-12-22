<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        function generateComplaintNumber() {
            var randomNumber = Math.floor(Math.random() * 1000);
            document.getElementById('randomNumberLabel').textContent = randomNumber;
            document.getElementById('randomNumberInput').value = randomNumber;
        }
    </script>
</head>
<body onload="generateComplaintNumber()">
    <%
    String n1 = (String) session.getAttribute("patientlogin");
    if (n1 != null) {
        out.println("Welcome " + n1);
        %>
        <form action="patienthelp.jsp" method="post">
            <br><br>
            <label for="Problem">Problem:</label>
            <select id="Problem" name="Problem">
            <option value="Fever">Fever</option>
            <option value="Heart">Heart</option>
            <option value="Headache">Headache</option>
            <option value="Body Pain">Body Pain</option>
            <option value="Liver">Body Pain</option>
            </select><br><br>
            <label for="Time">Time:</label>
            <input type="time" id="Time" name="Time"><br><br>
            <label for="Date">Date:</label>
            <input type="date" id="Date" name="Date"><br><br>
            <label for="Days">Days:</label>
            <input type="number" id="Days" name="Days"><br><br>
            <label>Complaint No:</label>
            <span id="randomNumberLabel"></span>
            <input type="hidden" id="randomNumberInput" name="randomNumber"><br><br>
            <label>Symptoms</label>
            <input type="text" id="Symptoms" name="Symptoms"><br><br>

            <input type="submit" value="Submit">
        </form>
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
