<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaint</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        .welcome-message {
            margin-bottom: 20px;
        }
        .complaint-details {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%
    String n1 = (String) session.getAttribute("doctorlogin");
    if (n1 != null) {
        out.println("<div class='welcome-message'>Welcome " + n1 + "</div>");
        int comp = Integer.parseInt(request.getParameter("complaintNo"));
        Connection cn = null;
        PreparedStatement prst = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedicalHelpline", "root", "12345");
            String query = "SELECT * FROM help WHERE ComplaintNo = ?";
            prst = cn.prepareStatement(query);
            prst.setInt(1, comp);
            ResultSet rs = prst.executeQuery();
            if (rs.next()) {
                String pi = rs.getString("PatientId");
                String problem = rs.getString("Problem");
                int days = rs.getInt("Days");
                String symptom=rs.getString("Symptoms");
                %>
                <div class="complaint-details">
                    <label>Patient Id: </label><span><%= pi %></span><br>
                    <label>Complaint No: </label><span><%= comp %></span><br>
                    <label>Problem: </label><span><%= problem %></span><br>
                    <label>Days: </label><span><%= days %></span><br>
                    <label>Symptom: </label><span><%= symptom %></span><br>
                </div>
                <form action="dgiveadvice.jsp" method="post">
                    <input type="hidden" name="ComplaintNo" value="<%= comp %>">
                    <div class="form-group">
                        <label for="Prescription">Prescription:</label>
                        <input type="text" id="Prescription" name="Prescription">
                    </div>
                    <div class="form-group">
                        <label for="Time">Time:</label>
                        <input type="time" id="Time" name="Time">
                    </div>
                    <div class="form-group">
                        <label for="Date">Date:</label>
                        <input type="date" id="Date" name="Date">
                    </div>
                    <div class="form-group">
                        <label for="Status">Status:</label>
                        <select id="Status" name="Status">
                            <option value="Done">Done</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Submit">
                    </div>
                </form>
                <%
            } else {
                out.println("No complaint found with this number.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Exception occurred: " + e.getMessage());
        } finally {
            try {
                if (prst != null) {
                    prst.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                out.println("Error closing resources: " + e.getMessage());
            }
        }
    } else {
        out.println("No user is logged in.");
    }
    %>
</body>
</html>
