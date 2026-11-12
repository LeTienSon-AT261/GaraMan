<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*" %>
<!DOCTYPE html>
<html>
<head><title>Customer Main UI</title></head>
<body>
    <h2>Trang chủ Khách hàng</h2>
    <% Customer customer = (Customer) session.getAttribute("customer"); if (customer == null) { customer = new Customer(); customer.setId(1); customer.setName("Khách Demo"); session.setAttribute("customer", customer); } %>
    <p>Xin chào, <%= customer.getName() %></p>
    <a href="BookAppointmentUI.jsp" name="subBookAppointment">Đặt lịch hẹn</a>
</body>
</html>