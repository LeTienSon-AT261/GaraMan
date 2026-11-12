<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="dao.*,model.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Book Appointment UI</title>
  </head>
  <body>
    <h2>Đặt lịch hẹn</h2>
    <form action="BookAppointmentUI.jsp" method="post">
      <table>
        <tr>
          <td>Họ tên:</td>
          <td><input type="text" name="inName" required /></td>
        </tr>
        <tr>
          <td>Ngày sinh:</td>
          <td><input type="text" name="inDateOfBirth" /></td>
        </tr>
        <tr>
          <td>Số điện thoại:</td>
          <td><input type="text" name="inPhone" required /></td>
        </tr>
        <tr>
          <td>Email:</td>
          <td><input type="text" name="inEmail" /></td>
        </tr>
        <tr>
          <td>Địa chỉ:</td>
          <td><input type="text" name="inAddress" /></td>
        </tr>
        <tr>
          <td>Ngày hẹn:</td>
          <td><input type="date" name="inDate" required /></td>
        </tr>
        <tr>
          <td>Giờ hẹn:</td>
          <td><input type="time" name="inTime" required /></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" name="subConfirm" value="Xác nhận" /></td>
        </tr>
      </table>
    </form>
    <% if (request.getParameter("subConfirm") != null)
    {Customer customer = (Customer) session.getAttribute("customer");
            String dateStr = request.getParameter("inDate"); String time = request.getParameter("inTime");
            java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            AppointmentDAO dao = new AppointmentDAO();
            Appointment appointment = dao.createAppointment(customer, date,
      time);
            if (dao.saveAppointment(appointment)) {
        out.print("<p style="color: green">Đặt lịch thành công!</p>");
      }
      else {out.print("<p style="color: red">Đặt lịch thất bại!</p>");}
    }
    %>
  </body>
</html>
