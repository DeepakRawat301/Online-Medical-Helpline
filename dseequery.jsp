<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
    String n1 = (String) session.getAttribute("doctorlogin");
    if (n1 != null) {
        out.println("Welcome " + n1);
        Connection cn = null;
        PreparedStatement prst = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedicalHelpline", "root", "12345");
            String query="Select * from help where DoctorId = ?";
            prst = cn.prepareStatement(query);
            prst.setString(1, n1);
            ResultSet rs = prst.executeQuery();
            while(rs.next())
            {
              String pi=rs.getString("PatientId");
              int comp=rs.getInt("ComplaintNo");
              String problem=rs.getString("Problem");
              int days=rs.getInt("Days");
                    %>
                    <div>
                    <form action="dadvicesave.jsp" method="post"></form>
                    <label>Patient Id</label>
                    <label><%= pi %></label><br><br>
                    <label>Complaint No</label>
                    <label><%= comp %></label><br><br>
                    <label>Problem</label>
                    <label><%= problem %></label><br><br>
                    <label>Days</label>
                    <label><%= days %></label><br><br>
                    <label>Prescription</label><br>
                    <input type="text" name="Prescription"><br><br>
                    <label for="Time">Time:</label>
                    <input type="time" id="Time" name="Time"><br><br>
                    <label for="Date">Date:</label>
                    <input type="date" id="Date" name="Date"><br><br>
                    <label for="Status">Status:</label>
                    <select id="Status" name="Status">
                    <option value="Done">Done</option>
                    <option value="Seen">Seen</option>
                    <option value="Pending">Pending</option>
                    </select><br><br>
                    <input type="submit" name="submit" value="Submit">
                    </div>
                    <form action="dlogout.jsp" method="post">
                        <input type="submit" value="Logout">
                        </form>
                    <%
               
            }


            }

            catch (ClassNotFoundException | SQLException e) {
                // Handle exceptions properly (log or display error message)
                out.println("Exception occurred: " + e.getMessage());
            } finally {
                // Close resources in finally block to ensure they are always closed
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