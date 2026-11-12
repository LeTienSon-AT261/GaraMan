<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head><title>Add Customer UI</title></head>
<body>
    <h2>Thêm khách hàng mới</h2>
    <form action="AddCustomerUI.jsp" method="post">
        <table>
            <tr><td>Họ tên:</td><td><input type="text" name="inFullName" required /></td></tr>
            <tr><td>Số điện thoại:</td><td><input type="text" name="inPhone" required /></td></tr>
            <tr><td>Email:</td><td><input type="text" name="inEmail" /></td></tr>
            <tr><td>Địa chỉ:</td><td><input type="text" name="inAddress" /></td></tr>
            <tr><td>Ngày sinh:</td><td><input type="text" name="inDateOfBirth" /></td></tr>
            <tr><td>Ghi chú:</td><td><input type="text" name="inNote" /></td></tr>
            <tr><td colspan="2"><b>Thông tin xe</b></td></tr>
            <tr><td>Tên xe:</td><td><input type="text" name="inNameCar" required /></td></tr>
            <tr><td>Biển số:</td><td><input type="text" name="inLicensePlate" required /></td></tr>
            <tr><td>Mô tả:</td><td><input type="text" name="inDescription" /></td></tr>
            <tr>
                <td></td>
                <td><input type="submit" name="subConfirm" value="Xác nhận" /><input type="submit" name="subCancel" value="Hủy" formnovalidate /></td>
            </tr>
        </table>
    </form>
    <% if (request.getParameter("subCancel") != null) { response.sendRedirect("CustomerSearchUI.jsp"); }
       if (request.getParameter("subConfirm") != null) {
            if (new CustomerDAO().addCustomer(request.getParameter("inFullName"), request.getParameter("inDateOfBirth"), request.getParameter("inPhone"), request.getParameter("inEmail"), request.getParameter("inAddress"), request.getParameter("inNote"))) {
                if (new CarDAO().addCar(request.getParameter("inNameCar"), request.getParameter("inLicensePlate"), request.getParameter("inDescription"))) {
                    out.print("<script>alert('Thêm thành công!'); window.location.href='CustomerSearchUI.jsp';</script>");
                }
            }
       } %>
</body>
</html>