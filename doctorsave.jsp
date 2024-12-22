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
    String userid = request.getParameter("UserId");
    String pass = request.getParameter("Password");
    String name = request.getParameter("Name");
    int age = Integer.parseInt(request.getParameter("Age"));
    String address = request.getParameter("Address");
    int mob = Integer.parseInt(request.getParameter("Mob"));
    String mail = request.getParameter("Mail");
    String gender = request.getParameter("Gender");
    String special = request.getParameter("Specialization");
    String date = request.getParameter("RDate");

    Connection cn = null;
    PreparedStatement prst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedicalHelpline", "root", "12345");

        String Dregisterquery = "INSERT INTO doctor (UserId, Password, Name, Age, Address, Mob, Mail, Gender, Specialization, RDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        prst = cn.prepareStatement(Dregisterquery);
        prst.setString(1, userid);
        prst.setString(2, pass);
        prst.setString(3, name);
        prst.setInt(4, age);
        prst.setString(5, address);
        prst.setInt(6, mob);
        prst.setString(7, mail);
        prst.setString(8, gender);
        prst.setString(9, special);
        prst.setString(10, date);

        int n = prst.executeUpdate();
        if (n > 0) {
            // Close resources before redirecting
            prst.close();
            cn.close();
            response.sendRedirect("adminop.jsp");
            return; // Stop further execution of JSP
        } else {
            out.println("Failed to register doctor");
        }
    } catch (ClassNotFoundException | SQLException e) {
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
    %>
</body>
</html>
